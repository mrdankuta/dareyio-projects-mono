# Step 16 - Bash Scripting Practice

## Control Flow

Shell scripts allow for control flow statements like if-else and case statements to execute code conditionally. The example code demonstrates using an if-elif-else statement to check if a number entered by the user is positive, negative, or zero. The if statement checks if the number is greater than 0 and prints a message that it is positive. The elif statement checks if the number is less than 0 and prints that it is negative. Finally, the else statement catches if the number is 0 and prints it is zero. This control flow allows the script to execute different logic depending on the input condition. If-else statements are fundamental to controlling logic flow in shell scripts.

```shell
#!/bin/bash

# Example script to check if a number is positive, negative, or zero

read -p "Enter a number: " num

if [ $num -gt 0 ]; then
    echo "The number is positive."
elif [ $num -lt 0 ]; then
    echo "The number is negative."
else
    echo "The number is zero."
fi

```
