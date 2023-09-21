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


## Week 2 Assignments
**Assignment 1:** Write a bash script that asks the user for their name and greets them

**Assignment 2:** Create a bash script that lists files in a directory as specified by the user and prints the first line from each file

**Assignment 3:** Write a python script to automate the process of copying files selected by a user from one folder into another

## Week 2 Topics and Code Samples

### Variables and Input / Output
- Variables are declared by assigning values to them: `variable_name=value`
- Variables are accessed by referencing them with a `$` at the start of the name: `$variable_name`
- Get user input with `read`
- Output with `echo` and `printf` to display text

### Conditional Statements
- `if`, `elif`, and `else` statements - syntax and examples
- Conditional execution based on user input
- Comparison operators: `-eq`, `-ne`, `-lt`, `-gt`, `-le`, `-ge` - usage in conditional statements
- `test` and `[ ]` constructs and how to use for conditional tests
### Loops
- `for` and `while` loops
- A compact way to execute repetitive tasks
- Loops have starting conditions, termination conditions and loop updates
```bash
#!/bin/bash
read -p "How many folders do you want to create: " count

for ((i = 1; i <= $count; i++)); do
    mkdir user_$i
done
```

```bash
#!/bin/bash

read -p "How many folders do you want to create: " count

if [[ $count =~ ^[0-9]+$ ]]; then
    while [ $count -gt 0 ]; do
        mkdir user_$count
        count=$((count - 1))
    done
else
    echo "Please type a number"
    exit
fi
```

### Loop control
- `break` and `continue` statements used for controlling loop execution
```bash
#!/bin/bash

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

### Functions
- Define functions with `function_name() { ... }`
- Call functions by name
- Function parameters and return values:
- Arguments passed functions must be specified in the function declaration
- Values are returned from functions using `return` keyword

```bash
mk_dir_struct() {
   mkdir $1
   mkdir $1/$2

   ROOTDIR=$1/$2
   mkdir $ROOTDIR/img
   mkdir $ROOTDIR/css
   mkdir $ROOTDIR/js

   touch $ROOTDIR/img/testing.png
   touch $ROOTDIR/css/testing.css
   touch $ROOTDIR/js/testing.js
}


read -p "Please type the name of the root folder: " root_name

if [ $root_name = "abort" ]; then
   # Abort the operation
   echo "You have requested to abort the operation"
elif [ -d $root_name ]; then
   # Tell the user directory already exists.
   echo "This directory $root_name already exists"
else
   mk_dir_struct $root_name html
fi
```

### Sample bash script that demonstrates various concepts
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


## Advanced Bash Scripting and Best Practices
### Case
`case` statement is used to handle more extensive conditionals
```bash

```
### File Operations
- Read and write files using `read`,  `cat`, `head`, `tail` while using a `while` loop to append to another file with `>>` or overwrite with `>`
- Common file handling commands `touch`, `cp`, `mv`, and `rm`

```bash
!/bin/bash

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
```

### Command-Line Arguments
- Command-line arguments are accessed using `$1`, `$2`, etc., `$@`, `$#`
- `shift` is used to parse command-line arguments one at a time
- `getopts` is used  for parsing command-line options and arguments

```bash
#!/bin/bash
# Accessing command-line arguments
echo "Accessing command-line arguments:"
echo "Script name: $0"
echo "First argument: $1"
echo "Second argument: $2"
```

```bash
#!/bin/bash
# Using shift
while [[ $# -gt 0 ]]; do
    case $1 in
        -f|--file)
          filename="$2"
          shift
          ;;
        -o|--output)
          outputfile="$2"
          shift
          ;;
        -n|--lines)
          lines="$2"
          shift
          ;;
        *)
          echo "Uknown option: $1"
          exit 1
          ;;
    esac
    shift
done
```

```bash
#!/bin/bash
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

### Regular Expressions and String Manipulation
### Regular Expression
- A sequence of symbols & characters that specifies a pattern to be matched text
- A “short-hand”, used by string searching algorithms for “find” & “find-replace” operations on strings
- `grep`, `sed` and `awk`
- `grep`, `sed` and `awk` powerful tools for text manipulation, find/replace in files
- `grep` - powerful for finding text patterns in files & aggregating content
- `sed` - useful in finding / modifying data in files, text substitution
- `awk` - a full fledged programming language with text processing capabilities, including comparisons and printing
```bash
#!/bin/bash

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
```

```bash
#!/bin/bash

# Sample text file (data.txt)
# Name, Age, City
# John, 25, New York
# Alice, 30, Los Angeles
# Bob, 22, Chicago

# Print the second column (Age) from the text file
awk -F', ' '{print $2}' data.txt

# Print names of people older than 25
awk -F', ' '$2 > 25 {print $1}' data.txt

# Calculate the average age from the data file
awk -F', ' '{sum += $2} END {print "Average age:", sum/NR}' data.txt

# Calculate the average age from the data file
awk -F', ' '{sum += $2} END {print "Average age:", sum/NR}' data.txt

# Print lines where the city is "New York"
awk -F', ' '/New York/ {print}' data.txt

# Calculate the sum of ages and print it
awk -F', ' 'BEGIN {sum = 0} {sum += $2} END {print "Total age:", sum}' data.txt
```

## Error Handling and Best Practices
### Error Handling
- Exit codes - exit codes are used to indicate success or failure of the script
- 0 for success, non-zero for failure
- `exit` command used to set custom exit codes
- `trap` command is used for signal handling - to capture and handle signals (e.g., `SIGINT`, `SIGTERM`)

```bash
#!/bin/bash

# Exit codes and error handling
echo "Exit codes and error handling:"
rm non_existent_file.txt
if [ $? -eq 0 ]; then
    echo "File removed successfully."
else
    echo "Error: File removal failed." >&2
fi
```

```bash
# Trap for signal handling
echo -e "\nTrap for signal handling:"
trap 'echo "Received SIGINT (Ctrl+C). Exiting..."; exit' SIGINT
while true; do
    sleep 1
done
```

### Best Practices
- Use the hash-bang / shebang (#!) to identify the shell to run your script
- Properly indent your code to ease readability
- Use recognizable and self-explanatory variable names
- Place comments where necessary to clarify your code
- Handle errors in your code and make room for user errors
- shellcheck can be used for script validation


```bash
#!/bin/bash

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
```
