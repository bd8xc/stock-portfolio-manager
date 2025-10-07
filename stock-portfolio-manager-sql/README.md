
# Stock Portfolio Manager SQL

A simple SQL-based project to manage stock portfolios.

## Project Structure

```
stock-portfolio-manager-sql/
│
├── schema/
│   ├── create_tables.sql       
│   ├── insert_sample_data.sql   
│   └── drop_tables.sql         
│
├── diagrams/
│   └── er_diagram.png           
│
├── README.md                    
└── LICENSE                      
```
### Table schema

---

### 1. Users

**Attributes:**

* `user_id` – INT, AUTO_INCREMENT
* `name` – VARCHAR(100), NOT NULL
* `email` – VARCHAR(100), UNIQUE, NOT NULL
* `created_at` – TIMESTAMP, DEFAULT CURRENT_TIMESTAMP

**Constraints:**

* Primary Key: `user_id`
* Unique: `email`

---

### 2. Stocks

**Attributes:**

* `stock_id` – INT, AUTO_INCREMENT
* `symbol` – VARCHAR(10), UNIQUE, NOT NULL
* `company_name` – VARCHAR(100), NOT NULL
* `current_price` – DECIMAL(10,2), NOT NULL
* `created_at` – TIMESTAMP, DEFAULT CURRENT_TIMESTAMP

**Constraints:**

* Primary Key: `stock_id`
* Unique: `symbol`

---

### 3. Portfolios

**Attributes:**

* `portfolio_id` – INT, AUTO_INCREMENT
* `user_id` – INT, NOT NULL
* `name` – VARCHAR(100), NOT NULL
* `created_at` – TIMESTAMP, DEFAULT CURRENT_TIMESTAMP

**Constraints:**

* Primary Key: `portfolio_id`
* Foreign Key: `user_id` → `Users(user_id)` ON DELETE CASCADE

---

### 4. Portfolio_Stocks

**Attributes:**

* `portfolio_stock_id` – INT, AUTO_INCREMENT
* `portfolio_id` – INT, NOT NULL
* `stock_id` – INT, NOT NULL
* `quantity` – INT, NOT NULL
* `avg_price` – DECIMAL(10,2), NOT NULL

**Constraints:**

* Primary Key: `portfolio_stock_id`
* Foreign Keys:

  * `portfolio_id` → `Portfolios(portfolio_id)` ON DELETE CASCADE
  * `stock_id` → `Stocks(stock_id)` ON DELETE CASCADE

---

### 5. Transactions

**Attributes:**

* `transaction_id` – INT, AUTO_INCREMENT
* `portfolio_id` – INT, NOT NULL
* `stock_id` – INT, NOT NULL
* `transaction_type` – ENUM('BUY','SELL'), NOT NULL
* `quantity` – INT, NOT NULL
* `price` – DECIMAL(10,2), NOT NULL
* `transaction_date` – DATETIME, DEFAULT CURRENT_TIMESTAMP

**Constraints:**

* Primary Key: `transaction_id`
* Foreign Keys:

  * `portfolio_id` → `Portfolios(portfolio_id)`
  * `stock_id` → `Stocks(stock_id)`

---

### 6. Stock_Prices

**Attributes:**

* `price_id` – INT, AUTO_INCREMENT
* `stock_id` – INT, NOT NULL
* `price` – DECIMAL(10,2), NOT NULL
* `price_date` – DATETIME, NOT NULL

**Constraints:**

* Primary Key: `price_id`
* Foreign Key: `stock_id` → `Stocks(stock_id)`

---

### 7. Dividends

**Attributes:**

* `dividend_id` – INT, AUTO_INCREMENT
* `stock_id` – INT, NOT NULL
* `amount` – DECIMAL(10,2), NOT NULL
* `dividend_date` – DATE, NOT NULL

**Constraints:**

* Primary Key: `dividend_id`
* Foreign Key: `stock_id` → `Stocks(stock_id)`

---

### 8. Alerts

**Attributes:**

* `alert_id` – INT, AUTO_INCREMENT
* `user_id` – INT, NOT NULL
* `stock_id` – INT, NOT NULL
* `target_price` – DECIMAL(10,2), NOT NULL
* `alert_type` – ENUM('ABOVE','BELOW'), NOT NULL
* `active` – BOOLEAN, DEFAULT TRUE

**Constraints:**

* Primary Key: `alert_id`
* Foreign Keys:

  * `user_id` → `Users(user_id)`
  * `stock_id` → `Stocks(stock_id)`

---

### 9. Watchlist

**Attributes:**

* `watchlist_id` – INT, AUTO_INCREMENT
* `user_id` – INT, NOT NULL
* `stock_id` – INT, NOT NULL
* `created_at` – TIMESTAMP, DEFAULT CURRENT_TIMESTAMP

**Constraints:**

* Primary Key: `watchlist_id`
* Foreign Keys:

  * `user_id` → `Users(user_id)`
  * `stock_id` → `Stocks(stock_id)`

---

### 10. Sectors

**Attributes:**

* `sector_id` – INT, AUTO_INCREMENT
* `name` – VARCHAR(50), UNIQUE, NOT NULL

**Constraints:**

* Primary Key: `sector_id`
* Unique: `name`

---

### 11. Stock_Sectors

**Attributes:**

* `stock_sector_id` – INT, AUTO_INCREMENT
* `stock_id` – INT, NOT NULL
* `sector_id` – INT, NOT NULL

**Constraints:**

* Primary Key: `stock_sector_id`
* Foreign Keys:

  * `stock_id` → `Stocks(stock_id)`
  * `sector_id` → `Sectors(sector_id)`

---

### 12. Settings

**Attributes:**

* `setting_id` – INT, AUTO_INCREMENT
* `user_id` – INT, NOT NULL
* `email_notifications` – BOOLEAN, DEFAULT TRUE
* `sms_notifications` – BOOLEAN, DEFAULT FALSE

**Constraints:**

* Primary Key: `setting_id`
* Foreign Key: `user_id` → `Users(user_id)`
* Relationship: 1:1 (each user has one settings row)

---


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
