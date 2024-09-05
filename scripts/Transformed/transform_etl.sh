#!/bin/bash

# Define paths for the directories and the original and transformed files
RAW_DIR="/mnt/c/Users/hp/ETL_Project/raw"
TRANSFORMED_DIR="/mnt/c/Users/hp/ETL_Project/Transformed"
ORIGINAL_FILE="$RAW_DIR/annual-enterprise-survey-2023-financial-year-provisional.csv"
TRANSFORMED_FILE="$TRANSFORMED_DIR/2023_year_finance.csv"

# Ensure the Transformed directory exists; create it if it doesn't
if [ ! -d "$TRANSFORMED_DIR" ]; then
    mkdir -p "$TRANSFORMED_DIR"
    echo "Created Transformed directory: $TRANSFORMED_DIR"
fi

# Check if the original file exists
if [ ! -f "$ORIGINAL_FILE" ]; then
    echo "Error: Original file not found in the raw directory."
    exit 1
fi

# Use awk to transform the CSV: rename column Variable_code to variable_code and select the required columns
# The script reads the header, modifies it, and then extracts the specified columns.
awk -F, 'BEGIN {OFS=","} 
{
    if (NR == 1) {
        # Modify the header to rename Variable_code to variable_code
        for (i = 1; i <= NF; i++) {
            if ($i == "Variable_code") {
                $i = "variable_code"
            }
        }
        print $1, $2, $3, $4
    } else {
        # Extract the columns year, Value, Units, and variable_code (assuming the original column positions)
        print $1, $2, $3, $4
    }
}' "$ORIGINAL_FILE" > "$TRANSFORMED_FILE"

# Confirm that the transformed file has been saved in the Transformed directory
if [ -f "$TRANSFORMED_FILE" ]; then
    echo "The transformed file has been successfully saved into the Transformed directory as 2023_year_finance.csv."
else
    echo "Error: The transformed file was not saved into the Transformed directory."
    exit 1  # Exit with an error code
fi

