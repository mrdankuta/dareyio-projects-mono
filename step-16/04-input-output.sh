#!/bin/bash

echo "Enter your name:"
read name

echo "Hello $name!" > index.txt

cat index.txt

# grep "pattern" < index.txt

# echo "hello world" | grep "pattern"