#!/bin/bash

# Example script to showcase the use of backticks and '$()' as Command Substitution methods

current_date_backtick=`date +%Y-%m-%d`

echo $current_date_backtick

current_date=$(date +%Y-%m-%d)

echo $current_date