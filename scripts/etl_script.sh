#!/bin/bash

# Environment variable for the URL
CSV_URL="C:\Users\hp\Downloads\annual-enterprise-survey-2023-financial-year-provisional"

# Directory paths
RAW_DIR="raw"
TRANSFORMED_DIR="Transformed"
GOLD_DIR="Gold"
MOVE_DIR="json_and_CSV"

# Extract: Download CSV file and save it into the 'raw' folder
echo "Extracting: Downloading CSV file..."
curl -o "$RAW_DIR/data.csv" "$CSV_URL"

# Confirm the file has been saved into the raw folder
if [ -f "$RAW_DIR/data.csv" ]; then
    echo "File has been successfully downloaded to $RAW_DIR."
else
    echo "Failed to download the file to $RAW_DIR."
    exit 1
fi

# Transform: Rename column Variable_code to variable_code and select specific columns
echo "Transforming: Renaming column and selecting specific columns..."
awk -F',' 'BEGIN {OFS=","} { if (NR == 1) { for (i = 1; i <= NF; i++) { if ($i == "Variable_code") $i = "variable_code" } print $1, $2, $3, $4 } else { print $1, $2, $3, $4 }}' "$RAW_DIR/data.csv" > "$TRANSFORMED_DIR/2023_year_finance.csv"

# Confirm the transformed file is saved in the Transformed folder
if [ -f "$TRANSFORMED_DIR/2023_year_finance.csv" ]; then
    echo "Transformation complete. File saved to $TRANSFORMED_DIR."
else
    echo "Transformation failed."
    exit 1
fi

# Load: Move the transformed data to the Gold directory
echo "Loading: Moving transformed data to Gold directory..."
mv "$TRANSFORMED_DIR/2023_year_finance.csv" "$GOLD_DIR/2023_year_finance.csv"

# Confirm the file has been saved into the Gold folder
if [ -f "$GOLD_DIR/2023_year_finance.csv" ]; then
    echo "File successfully moved to $GOLD_DIR."
else
    echo "Failed to move the file to $GOLD_DIR."
    exit 1
fi

# Move all CSV and JSON files from one folder to another folder named json_and_CSV
echo "Moving CSV and JSON files to $MOVE_DIR..."
find . -type f \( -name "*.csv" -o -name "*.json" \) -exec mv {} "$MOVE_DIR/" \;

echo "All CSV and JSON files have been moved to $MOVE_DIR."

