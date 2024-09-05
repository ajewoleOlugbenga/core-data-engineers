#!/bin/bash

# Define paths for the directories and the transformed and final files
TRANSFORMED_DIR="/mnt/c/Users/hp/ETL_Project/Transformed"
GOLD_DIR="/mnt/c/Users/hp/ETL_Project/Gold"
TRANSFORMED_FILE="$TRANSFORMED_DIR/2023_year_finance.csv"
GOLD_FILE="$GOLD_DIR/2023_year_finance.csv"

# Ensure the Gold directory exists; create it if it doesn't
if [ ! -d "$GOLD_DIR" ]; then
    mkdir -p "$GOLD_DIR"
    echo "Created Gold directory: $GOLD_DIR"
fi

# Check if the transformed file exists
if [ ! -f "$TRANSFORMED_FILE" ]; then
    echo "Error: Transformed file not found in the Transformed directory."
    exit 1
fi

# Move the transformed file to the Gold directory
mv "$TRANSFORMED_FILE" "$GOLD_FILE"

# Confirm that the transformed file has been moved to the Gold directory
if [ -f "$GOLD_FILE" ]; then
    echo "The file has been successfully moved to the Gold directory as 2023_year_finance.csv."
else
    echo "Error: The file was not saved into the Gold directory."
    exit 1  # Exit with an error code
fi

