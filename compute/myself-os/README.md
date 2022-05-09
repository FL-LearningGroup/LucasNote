# Run Environment
+ [WSL](https://docs.microsoft.com/en-us/windows/wsl/)(Windows Subsystem for Linux)
    - Entere `wsl --install` in an administrator PowerShell or Windows Command Prompt and then restarting your machine. 
+ Install Ubuntu 20.04 LTS
    + Use [WSL](https://docs.microsoft.com/en-us/windows/wsl/install) install it on Windows

# Developement Tools

+ VSCode: [windows platform](https://code.visualstudio.com/download)
    - The C drive of windows is shared with Ubuntu by mounting. 

+ [QEMU](https://www.qemu.org/): A generic and open source machine emulator and virtualizer
    - `sudo apt-get install qemu-system`: The command will install all system. Includes i386, x86_64, arm and so on.

+ [nams](https://en.wikipedia.org/wiki/Netwide_Assembler) on Ubuntu
    ```bash
    sudo apt update
    sudo apt install nasm
    ```
+ `make` on Ubuntu
    ```bash
    sudo apt update
    sudo apt install make
    ```
+ Install `HomeBrew` on Ubuntu 20.04 LTS
    ```bash
    sudo apt update
    sudo apt-get install build-essential
    sudo apt install git -y
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.bash_profile
    echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.profile
    brew -v
    ```
+ Install `comipler` and `linker`
    ```bash
    brew install i386-elf-binutils
    brew install i386-elf-gcc
    brew install i386-elf-gdb
    ```