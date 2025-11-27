/*
 * BaikalOS Dummy SU
 * This binary mimics the standard su interface but executes 
 * everything within the current process context/UID.
 *
 * Copyright (C) 2026 BaikalOS
 */

#include <iostream>
#include <vector>
#include <unistd.h>
#include <string.h>
#include <sys/types.h>

void print_help() {
    std::cout << "BaikalOS su-dummy" << std::endl;
    std::cout << "Usage: su [options] [args]" << std::endl;
    std::cout << "Options:" << std::endl;
    std::cout << "  -c, --command COMMAND         pass COMMAND to the shell" << std::endl;
    std::cout << "  -v, --version                 print version and exit" << std::endl;
}

int main(int argc, char* argv[]) {
    // Some apps check version to verify "root" status
    if (argc > 1 && (strcmp(argv[1], "-v") == 0 || strcmp(argv[1], "--version") == 0)) {
        std::cout << "3.0:BaikalOS:FakeRoot" << std::endl;
        return 0;
    }

    if (argc > 1 && (strcmp(argv[1], "-h") == 0 || strcmp(argv[1], "--help") == 0)) {
        print_help();
        return 0;
    }

    const char* shell_path = "/system/bin/sh";

    // Scenario 1: Just "su" called -> open shell
    if (argc == 1) {
        execl(shell_path, "sh", nullptr);
        return 1; // Should not reach here
    }

    // Scenario 2: "su -c 'command'"
    if (argc >= 3 && strcmp(argv[1], "-c") == 0) {
        // Execute command as current user
        execl(shell_path, "sh", "-c", argv[2], nullptr);
        return 1;
    }

    // Scenario 3: Fallback for other arguments
    // Reconstruct arguments to pass to sh
    std::vector<char*> args;
    args.push_back(const_cast<char*>("sh"));
    for (int i = 1; i < argc; ++i) {
        // Skip common su flags that sh doesn't understand
        if (strcmp(argv[i], "-c") == 0) continue; 
        args.push_back(argv[i]);
    }
    args.push_back(nullptr);

    execv(shell_path, args.data());

    return 0;
}
