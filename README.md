# CoreDataEngineers Data Engineering Task

## Repository Structure

- `Scripts/`: Contains all scripts for ETL processes and database operations.
  - `Bash/`: Contains Bash scripts.
    - `etl_process.sh`: ETL process script.
    - `move_files.sh`: Script to move CSV and JSON files.
    - `copy_to_postgres.sh`: Script to copy CSV files into PostgreSQL.
  - `SQL/`: Contains SQL scripts.
    - `find_order_ids.sql`: Query to find order IDs with specific quantities.
    - `list_orders.sql`: Query to list orders with zero standard_qty and high gloss_qty or poster_qty.
    - `company_names.sql`: Query to find company names with specific criteria.
    - `sales_rep_regions.sql`: Query to show region, sales rep, and account details.

## Setup

1. Clone this repository:
   ```bash
   git clone https://github.com/ajewoleOlugbenga/core-data-engineers.git
2. cd core-data-engineers
3. Make sure you have PostgreSQL installed and configured.
   Update database credentials in the copy_to_postgres.sh script.
   Run the ETL script manually to test: bash Scripts/Bash/etl_process.sh
4. Schedule the ETL script using cron jobs.

ETL Diagram
