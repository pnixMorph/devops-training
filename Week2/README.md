## Week 2 Task

#### Task 1: Create a directory structure for a new website
- Create a new directory in your home directory called `www`
- Create a sub-directory called `www/html`
- Create 3 sub-directories called `www/html/img`, `www/html/css`, and `www/html/js`
- In each folder make a file with the names `testing.png` (`img` folder), `testing.css` (`css` folder), and `testing.js` (`js` folder)

### Guidelines:
1. This task is to be first done manually
2. Thereafter automated in a script file called `automate.sh`.
3. This script file will also be improved to allow the user to specify a name for the top level directory (instead of `www`).
4. The script should also check if the directory exists already and give the user a warning if it does.
### Script vs. program
A script is a small piece of code used to automate small tasks
A program is a large and complex software application with a lot of functionality and features, such as operating systems and enterprise-level software
Lower-level system software, such as device drivers and system utilities are also considered programs
### Benefits of Scripting / Automation
Scripting skills are required for automation of tasks
Automation is a key element of the devops methodology
Streamlines and accelerates the software development lifecycle
By automating repetitive tasks, teams can focus on more strategic activities
### Scripting Languages
Python: Known for its simplicity and readability, Python is widely used in DevOps scripting
Bash: A default shell in most Unix-based systems, Bash is convenient for system administration tasks
PowerShell: Microsoft scripting language, PowerShell, is popular in Windows-based DevOps environments
### Bash Scripting Basics
Bash (Bourne Again Shell) is a Unix shell and command language
Knowledge of Bash is a fundamental skill for automating tasks in a Unix-like environment, which is common in DevOps practices.
Writing a script in bash at its most basic is rewriting the same commands typed in the console in a text editor and saving it as an executable script file
Text editors that can be used:
nano, vim, emacs, notepad
Save with a `.sh` extension, though not required
Ensure file is executable (`chmod +x scriptfile.sh`)
Run script by typing filename (either absolutive or relative filepath)
`./script.sh`
### Variables and Input / Output
Declaring variables:
Assign values to variables: `variable_name=value`
Access variable value: `$variable_name`
Get user input with `read`
Output with `echo` and `printf` to display text
### Conditional Statements
if`, `elif`, and `else` statements - syntax and examples
Conditional execution based on user input
Comparison operators: `-eq`, `-ne`, `-lt`, `-gt`, `-le`, `-ge` - usage in conditional statements
`test` and `[ ]` constructs and how to use for conditional tests
### Loops
`for` and `while` loops
A compact way to execute repetitive tasks
Loops have starting conditions, termination conditions and loop updates
### Loop control
`break` and `continue` statements used for controlling loop execution
### Functions
Define functions with `function_name() { ... }`
Call functions by name
Function parameters and return values:
Arguments passed functions must be specified in the function declaration
Values are returned from functions using `return` keyword
### Advanced Bash Scripting and Best Practices
### Case
Using the  `case` statement to handle more extensive conditions
### File Operations
Read and write files using `read`,  `cat`, `head`, `tail` while using a `while` loop to append to another file with `>>` or overwrite with `>`
Introduce common file handling commands like `touch`, `cp`, `mv`, and `rm`
### Command-Line Arguments
Command-line arguments are accessed using `$1`, `$2`, etc., `$@`, `$#`
 `shift` is used to parse command-line arguments one at a time
`getopts` is used  for parsing command-line options and arguments
### Regular Expressions and String Manipulation
### Regular Expression
A sequence of symbols & characters that specifies a pattern to be matched text
A “short-hand”, used by string searching algorithms for “find” & “find-replace” operations on strings
`grep`, `sed` and `awk`
`grep`, `sed` and `awk` powerful tools for text manipulation, find/replace in files
`grep` - powerful for finding text patterns in files & aggregating content
`sed` - useful in finding / modifying data in files, text substitution
`awk` - a full fledged programming language with text processing capabilities, including comparisons and printing
### Error Handling and Best Practices
### Error Handling
Exit codes - exit codes are used to indicate success or failure of the script
0 for success, non-zero for failure
`exit` command used to set custom exit codes
`trap` command is used for signal handling - to capture and handle signals (e.g., SIGINT, SIGTERM)
### Best Practices
Use the hash-bang / shebang (#!) to identify the shell to run your script
Properly indent your code to ease readability
Use recognizable and self-explanatory variable names
Place comments where necessary to clarify your code
Handle errors in your code and make room for user errors
shellcheck can be used for script validation


```bash
#!/bin/bash

# This is a sample Bash script

# Function to greet the user
greet_user() {
    echo "Hello, $1!"
}

# Function to list files in the current directory
list_files() {
    echo "Files in the current directory:"
    ls
}

# Main script starts here
echo "Welcome to the Greeting and File Listing Script!"

# Read the user's name
read -p "Please enter your name: " user_name

# Call the greet_user function to greet the user
greet_user "$user_name"

# Ask if the user wants to list files
read -p "Would you like to list files in the current directory? (yes/no): " choice

# Check the user's choice
if [ "$choice" = "yes" ]; then
    # Call the list_files function to list files
    list_files
elif [ "$choice" = "no" ]; then
    echo "Okay, have a great day!"
else
    echo "Invalid choice. Please enter 'yes' or 'no'."
fi

# End of the script
```
```
``` #!/bin/bash

# Example of for loop
echo "Example of a for loop:"
for ((i = 1; i <= 5; i++)); do
    echo "Iteration $i"
done

# Example of while loop with loop control
echo -e "\nExample of a while loop with loop control:"
count=1
while [ $count -le 10 ]; do
    if [ $count -eq 3 ]; then
        echo "Skipping iteration $count"
        count=$((count + 1))
        continue  # Skip the rest of the loop body and continue to the next iteration
    elif [ $count -eq 7 ]; then
        echo "Breaking out of the loop at iteration $count"
        break  # Exit the loop
    fi
    echo "Iteration $count"
    count=$((count + 1))
done

# End of the script
```
```#!/bin/bash

# Define a function with two parameters
concat_strings() {
    # $1 and $2 represent the first and second parameters passed to the function
    local string1="$1"
    local string2="$2"
    
    # Concatenate the two strings and print the result
    local result="${string1}${string2}"
    echo "Concatenated string: $result"
}

# Main script starts here
echo "Function Example: Concatenate Two Strings"

# Call the function with two strings as arguments
concat_strings "Hello, " "World!"

# End of the script```
```#!/bin/bash

string="12345"

if [[ $string =~ ^[0-9]+$ ]]; then
    echo "The string '$string' contains only digits."
else
    echo "The string '$string' contains characters other than digits."
fi


```
```!/bin/bash

# Example of reading a file
echo "Example of reading a file:"
while IFS= read -r line; do
    echo "Line: $line"
done < sample.txt

# Example of writing to a file
echo -e "\nExample of writing to a file:"
echo "This is a test." > output.txt
echo "Another line." >> output.txt
cat output.txt

# File handling commands
echo -e "\nFile handling commands:"
touch newfile.txt         # Create a new file
cp output.txt copy.txt    # Copy a file
mv copy.txt moved.txt     # Rename a file
rm moved.txt              # Remove a file


``` #!/bin/bash

# Accessing command-line arguments
echo "Accessing command-line arguments:"
echo "Script name: $0"
echo "First argument: $1"
echo "Second argument: $2"

# Parsing options with getopts
echo -e "\nParsing options with getopts:"
while getopts ":a:b:" opt; do
    case $opt in
        a)
            arg_a="$OPTARG"
            echo "Option -a with argument: $arg_a"
            ;;
        b)
            arg_b="$OPTARG"
            echo "Option -b with argument: $arg_b"
            ;;
        \?)
            echo "Invalid option: -$OPTARG" >&2
            ;;
    esac
done
```
```#!/bin/bash

# Exit codes and error handling
echo "Exit codes and error handling:"
rm non_existent_file.txt
if [ $? -eq 0 ]; then
    echo "File removed successfully."
else
    echo "Error: File removal failed." >&2
fi

```
### Trap for signal handling
echo -e "\nTrap for signal handling:"
trap 'echo "Received SIGINT (Ctrl+C). Exiting..."; exit' SIGINT
while true; do
    sleep 1
done
``` #!/bin/bash

# Using grep for text manipulation
echo "Using grep for text manipulation:"
echo "Searching for 'apple' in fruits.txt:"
grep "apple" fruits.txt

# Using sed for text substitution
echo -e "\nUsing sed for text substitution:"
echo "Original content:"
cat sample.txt
echo -e "\nReplacing 'old' with 'new':"
sed 's/old/new/g' sample.txt
``` ```
```#!/bin/bash

# Code formatting and commenting
echo "Code formatting and commenting:"
# This is a comment
variable="Hello, world!" # Another comment

# Debugging techniques
echo -e "\nDebugging techniques:"
set -x
echo "Debugging is enabled."
set +x
echo "Debugging is disabled."

# ShellCheck for script validation
echo -e "\nShellCheck for script validation:"
shellcheck script.sh

```#!/bin/bash

# Sample text file (data.txt)
# Name, Age, City
# John, 25, New York
# Alice, 30, Los Angeles
# Bob, 22, Chicago

# Print the second column (Age) from the text file
awk -F', ' '{print $2}' data.txt

````#!/bin/bash

# Print names of people older than 25
awk -F', ' '$2 > 25 {print $1}' data.txt

```#!/bin/bash

# Calculate the average age from the data file
awk -F', ' '{sum += $2} END {print "Average age:", sum/NR}' data.txt

```
```#!/bin/bash

# Calculate the average age from the data file
awk -F', ' '{sum += $2} END {print "Average age:", sum/NR}' data.txt

```
```#!/bin/bash

# Print lines where the city is "New York"
awk -F', ' '/New York/ {print}' data.txt

```
```#!/bin/bash

# Calculate the sum of ages and print it
awk -F', ' 'BEGIN {sum = 0} {sum += $2} END {print "Total age:", sum}' data.txt

``` 
```name = "John"
age = 25
height = 1.75

```
```user_input = input("Enter something: ")
print("You entered:", user_input)

```
```x = 10
if x > 5:
    print("x is greater than 5")
elif x == 5:
    print("x is equal to 5")
else:
    print("x is less than 5")

```
```for i in range(1, 6):
    print("Iteration", i)

count = 1
while count <= 5:
    print("Iteration", count)
    count += 1

```
```def greet(name):
    print("Hello,", name)

greet("Alice")

```
```import math

result = math.sqrt(16)
print("Square root of 16 is", result)
```
```# Writing to a file
with open("output.txt", "w") as file:
    file.write("This is a test.")

# Reading from a file
with open("output.txt", "r") as file:
    content = file.read()
    print("File content:", content)
```
```try:
    result = 10 / 0
except ZeroDivisionError:
    print("Error: Division by zero")
finally:
    print("Execution completed.")
```
```import logging

logging.basicConfig(filename="error.log", level=logging.ERROR)

try:
    result = 10 / 0
except ZeroDivisionError as e:
    logging.error("Error: Division by zero")
```
