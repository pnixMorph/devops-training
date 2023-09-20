## Week 2 Python Scripting
- Variable - a symbolic name or identifier that represents a value or data stored in computer memory
- Container for holding different types of data, such as numbers, text, or objects
- Declared by assigning to a value, e.g. `name = "John Doe"`, data type not required, even though good practice, e.g. `name: str = “John”`
#### Common data types
- Integer (`int`) - Whole numbers (e.g., 5, -10)
- Floating-Point (`float`) - Decimal numbers (e.g., 3.14, -0.001)
- String (`str`) - Textual data (e.g., "Hello, World!")
- Boolean (`bool`) - Represents `True` or `False`
- List (`list`) - Ordered collection of items (e.g., [1, 2, 3])
- Tuple (`tuple`) - Ordered and immutable collection (e.g., (1, 2, 3))
- Dictionary (`dict`) - Unordered key-value pairs (e.g., {'name': 'Alice'})
- Set (`set`) - Unordered collection of unique elements (e.g., {1, 2, 3})
- NoneType (`None`) - Represents the absence of a value

### Variables
```python
# Variables, data types, and type conversion
name = "John"
age = 25
height = 1.75

print("name", name)
print("age", age)
print("height", height)
```

### Basic Input and Output
- Use `input()` to get user input.
- Use `print()` to display output to user
```python
# Get input from the user.
user_input = input("Enter something: ")
print("You entered: ", user_input)

# Convert (cast) the str input into an int
x = int(user_input)
if x > 5:
    print("x is greater than 5")
elif x == 5:
    print("x is equal to 5")
else:
    print("x is less than 5")
```

### Control Flow
- Conditional statements use the `if`, `elif`, `else` syntax
- Logical operators are used in conditional statements - `==`, `>`, `<`, `!=`, `>=`, `<=`, `and`, `or`, `not`
- Iterating through sequences are done with loops using `for` and `while` keywords
- `for` uses iterators, `while` uses a continuation condition
```python
age = int(input("Type in your age: "))
# Conditional statements
if age >= 18:
    print("You are an adult.")
elif age >= 13:
    print("You are a teenager.")
else:
    print("You are a child.")

# Loops
for i in range(5):
    print("Iteration", i)

for i in range(1, 6):
    print("Iteration", i)

count = 0
while count < 5:
    print("Count:", count)
    count += 1
```

### Functions and Modules
```python
def greet(name):
    print("Hello,", name)

greet("Alice")

import math

result = math.sqrt(16)
print("Square root of 16 is", result)
```

```python
# Defining and calling functions
def greet(name):
    return "Hello, " + name

message = greet("Alice")
print(message)

# Importing and using modules
import os
current_directory = os.getcwd()
print("Current directory:", current_directory)

```

### File Handling
- Use the `open` and `read` keywords to read text from files
- Use the `open` and `write` keywords to write text to files
- `os` and `shutil` built-in modules have a lot of utilities for file manipulation
- `os.rename()` to rename, `os.remove()` to delete, `shutil.copy()` to copy
- `os.listdir()` to list files in a directory

```python
# Reading from a file
with open("output.txt", "r") as file:
    content = file.read()
    print("File content:", content)
    
# Writing to a file
with open("output.txt", "w") as file:
    file.write("This is a test.\n")
    file.write("This is another line.\n")
```

```python
# File manipulation
import os
import shutil

# Move a file to a new location
source_path = "old_file.txt"
destination_path = "new_location/old_file.txt"
os.rename(source_path, destination_path)

# Copy a file to a new location
source_path = "source_file.txt"
destination_path = "destination_folder/"
shutil.copy(source_path, destination_path)

# Delete a file
file_to_delete = "file_to_delete.txt"
if os.path.exists(file_to_delete):
    os.remove(file_to_delete)
else:
    print("File does not exist.")


# Appending data to an existing file
with open("existing_file.txt", "a") as file:
    file.write("This is additional data.\n")

# List files and directories in a directory
directory_path = "/path/to/directory"
contents = os.listdir(directory_path)
for item in contents:
    print(item)
```

### Error Handling
- Exceptions / errors handled using `try`, `except`, `finally`
- Handle common exceptions (e.g., `FileNotFoundError`)
- `finally` always runs and is good for cleanup
- Python’s logging module can be used to log errors - easy and intuitive
- `import logging`, then `logging.error(“A message into the log”)`

```python
try:
    result = 10 / 0
except ZeroDivisionError:
    print("Error: Division by zero")
finally:
    print("Execution completed.")

import logging
logging.basicConfig(filename="error.log", level=logging.ERROR)

try:
    result = 10 / 0
except ZeroDivisionError as e:
    logging.error("Error: Division by zero")
```
