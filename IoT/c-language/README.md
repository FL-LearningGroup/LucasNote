# History
https://baijiahao.baidu.com/s?id=1679407894068585114&wfr=spider&for=pc

# Install C language on Linux

## Ubuntu
+ sudo apt update
+ sudo apt install build-essential gdb
+ gcc --version

(Command 'gcc' not found, but can be installed with:
sudo apt install gcc)

## Red Hat Linux/Fedora/CentOS
+ yum update
+ yum groupinstall 'Development Tools' gdb
+ sudo yum group install "Development Tools" gdb

(Command 'gcc' not found, but can be installed with:
sudo apt install gcc)

# Language fundamental
## Data Type
+ character
    - char
+ integer
    - short
    - int
    - long
+ floating
    - double
    - float
+ pointer
+ array
+ structuer
+ union

# Constraints
1. All variables must be declared before they are used, usually at the begining of the function before any executable statements.
2. The size of the data type are machine-dependent.
3. If an arithmetic operator has one floating-point operand and one integer operand, however, the integer will be converted to floating point before the operation done.
