
/*
 * BaikalOS Dummy SU
 * Magisk-style su interface without changing UID/GID.
 *
 * Copyright (C) 2026 BaikalOS
 */

#include <iostream>
#include <string>
#include <vector>
#include <unistd.h>
#include <string.h>
#include <errno.h>
#include <fcntl.h>
#include <sys/types.h>
#include <android/log.h>

#define LOG_TAG "BaikalOS-su-dummy"
#define LOGI(...) __android_log_print(ANDROID_LOG_INFO, LOG_TAG, __VA_ARGS__)
#define LOGE(...) __android_log_print(ANDROID_LOG_ERROR, LOG_TAG, __VA_ARGS__)

static const char* DEFAULT_SHELL = "/system/bin/sh";

static void print_help() {
    std::cout
        << "BaikalOS su-dummy\n"
        << "Usage: su [options] [--] [user [argument...]]\n"
        << "Options:\n"
        << "  -c, --command COMMAND       execute COMMAND through the shell\n"
        << "  -s, --shell SHELL           use SHELL instead of /system/bin/sh\n"
        << "  -l, --login                 run shell as a login shell\n"
        << "  -m, -p, --preserve-environment\n"
        << "  -v, --version               print version and exit\n"
        << "  -V                          print version code and exit\n"
        << "  -h, --help                  print this help and exit\n";
}

static void log_arguments(const char* prefix, int argc, char* const argv[]) {
    for (int i = 0; i < argc; ++i) {
        LOGI("%s argv[%d] = '%s'",
             prefix, i, argv[i] ? argv[i] : "(null)");
    }
}

static void log_fd(const char* name, int fd) {
    errno = 0;
    const int flags = fcntl(fd, F_GETFD);

    if (flags < 0) {
        const int err = errno;
        LOGE("%s fd=%d unavailable: errno=%d (%s)",
             name, fd, err, strerror(err));
        return;
    }

    LOGI("%s fd=%d open, FD_CLOEXEC=%d, isatty=%d",
         name, fd,
         (flags & FD_CLOEXEC) ? 1 : 0,
         isatty(fd) ? 1 : 0);
}

static int exec_shell(const char* shell, std::vector<char*>& args) {
    args.push_back(nullptr);

    LOGI("Executing shell: '%s'", shell);

    for (size_t i = 0; args[i] != nullptr; ++i) {
        LOGI("exec argv[%zu] = '%s'", i, args[i]);
    }

    log_fd("stdin", STDIN_FILENO);
    log_fd("stdout", STDOUT_FILENO);
    log_fd("stderr", STDERR_FILENO);

    LOGI("Identity: uid=%d euid=%d gid=%d egid=%d",
         getuid(), geteuid(), getgid(), getegid());

    // Replace this process directly. Do not fork or wait:
    // the caller's standard streams remain attached to the shell.
    execv(shell, args.data());

    const int err = errno;
    LOGE("execv('%s') failed: errno=%d (%s)",
         shell, err, strerror(err));

    return 127;
}

int main(int argc, char* argv[]) {

    /*if (geteuid() == 0) {
        if (setgid(0) != 0) {
            LOGE("setgid(0) failed: %s", strerror(errno));
            return 1;
        }

        if (setuid(0) != 0) {
            LOGE("setuid(0) failed: %s", strerror(errno));
            return 1;
        }
    }

    LOGI("After setuid/setgid: uid=%d euid=%d gid=%d egid=%d",
         getuid(), geteuid(), getgid(), getegid());*/


    LOGI("Started: argc=%d uid=%d euid=%d gid=%d egid=%d",
         argc, getuid(), geteuid(), getgid(), getegid());

    log_arguments("input", argc, argv);

    if (argc > 1 &&
        (strcmp(argv[1], "-h") == 0 ||
         strcmp(argv[1], "--help") == 0)) {
        print_help();
        return 0;
    }

    if (argc > 1 &&
        (strcmp(argv[1], "-v") == 0 ||
         strcmp(argv[1], "--version") == 0)) {
        std::cout << "3.0:BaikalOS:FakeRoot" << std::endl;
        return 0;
    }

    if (argc > 1 && strcmp(argv[1], "-V") == 0) {
        std::cout << "30000" << std::endl;
        return 0;
    }

    const char* shell = DEFAULT_SHELL;
    bool login = false;
    bool command_set = false;
    std::string command;
    int i = 1;

    while (i < argc) {
        if (strcmp(argv[i], "--") == 0) {
            ++i;
            break;
        }

        if (strcmp(argv[i], "-c") == 0 ||
            strcmp(argv[i], "--command") == 0) {
            ++i;

            if (i >= argc) {
                LOGE("-c requires a command");
                return 1;
            }

            // Join the command and all remaining arguments.
            // Supports both: su -c ls -la
            //            and: su -c "ls -la"
            for (; i < argc; ++i) {
                if (!command.empty()) {
                    command += ' ';
                }
                command += argv[i];
            }

            command_set = true;
            break;
        }

        if (strcmp(argv[i], "-s") == 0 ||
            strcmp(argv[i], "--shell") == 0) {
            if (++i >= argc) {
                LOGE("-s requires a shell path");
                return 1;
            }

            shell = argv[i++];
            continue;
        }

        if (strcmp(argv[i], "-l") == 0 ||
            strcmp(argv[i], "--login") == 0 ||
            strcmp(argv[i], "-") == 0) {
            login = true;
            ++i;
            continue;
        }

        if (strcmp(argv[i], "-m") == 0 ||
            strcmp(argv[i], "-p") == 0 ||
            strcmp(argv[i], "--preserve-environment") == 0) {
            ++i;
            continue;
        }

        // A positional user name is accepted but never applied:
        // this implementation does not switch identities.
        if (argv[i][0] != '-') {
            LOGI("Ignoring positional argument: '%s'", argv[i]);
            ++i;
            continue;
        }

        LOGE("Unsupported option: '%s'", argv[i]);
        return 1;
    }

    std::vector<char*> args;

    if (command_set) {
        LOGI("Command: '%s'", command.c_str());

        std::string arg0 = login ? "-" : "sh";

        args.push_back(const_cast<char*>(arg0.c_str()));
        args.push_back(const_cast<char*>("-c"));
        args.push_back(const_cast<char*>(command.c_str()));

        return exec_shell(shell, args);
    }

    // No command: launch a persistent shell.
    std::string shell_name = shell;
    const size_t slash = shell_name.find_last_of('/');

    if (slash != std::string::npos) {
        shell_name = shell_name.substr(slash + 1);
    }

    std::string arg0 = login ? "-" + shell_name : shell_name;
    args.push_back(const_cast<char*>(arg0.c_str()));

    // Preserve any remaining positional arguments.
    for (; i < argc; ++i) {
        args.push_back(argv[i]);
    }

    LOGI("Starting persistent shell; login=%d", login ? 1 : 0);

    return exec_shell(shell, args);
}
