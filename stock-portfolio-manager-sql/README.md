
# Stock Portfolio Manager SQL

A simple SQL-based project to manage stock portfolios. This project includes database schema creation, sample data insertion, and cleanup scripts.

## Project Structure

```
stock-portfolio-manager-sql/
│
├── schema/
│   ├── create_tables.sql        # SQL script to create tables
│   ├── insert_sample_data.sql   # SQL script to insert sample data
│   └── drop_tables.sql          # SQL script to drop tables
│
├── diagrams/
│   └── er_diagram.png           # ER diagram of the database
│
├── README.md                    # Project overview
└── LICENSE                      # Project license
```

## Setup

1. Make sure you have MySQL or another SQL database installed.
2. Open a terminal and navigate to the `schema/` directory.
3. Run the scripts in the following order:

```sql
source create_tables.sql;

source insert_sample_data.sql;
```

4. To clean up, run:

```sql
source drop_tables.sql;
```

## License

This project is licensed under the MIT License.
