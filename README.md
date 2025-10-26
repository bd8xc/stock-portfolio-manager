# Stock Portfolio Management Database

## Abstract

This database manages **users**, their **stock portfolios**, **transactions**, **watchlists**, and related **stock market information**.

It supports:

* Tracking **real-time stock prices**
* Recording **dividend payouts**
* Managing **sector classifications**
* Setting **user alerts** and **notifications**
* Maintaining **data integrity** with proper constraints

Data integrity is enforced using **primary keys**, **foreign keys**, **unique constraints**, and **appropriate data types**.

---

## Database Tables & Schema

### 1. Users

Stores system users.

| Column     | Type                                | Notes             |
| ---------- | ----------------------------------- | ----------------- |
| user_id    | INT AUTO_INCREMENT PRIMARY KEY      | Unique identifier |
| name       | VARCHAR(100) NOT NULL               | User's name       |
| email      | VARCHAR(100) UNIQUE NOT NULL        | User's email      |
| created_at | TIMESTAMP DEFAULT CURRENT_TIMESTAMP | Creation time     |

---

### 2. Stocks

Details of available stocks.

| Column        | Type                           | Notes           |
| ------------- | ------------------------------ | --------------- |
| stock_id      | INT AUTO_INCREMENT PRIMARY KEY | Unique stock ID |
| symbol        | VARCHAR(10) UNIQUE NOT NULL    | Stock symbol    |
| company_name  | VARCHAR(100) NOT NULL          | Company name    |
| current_price | DECIMAL(10,2)                  | Latest price    |

---

### 3. Portfolios

Represents user portfolios.

| Column       | Type                           | Notes               |
| ------------ | ------------------------------ | ------------------- |
| portfolio_id | INT AUTO_INCREMENT PRIMARY KEY | Portfolio ID        |
| user_id      | INT                            | FK → Users(user_id) |
| name         | VARCHAR(100)                   | Portfolio name      |

---

### 4. Portfolio_Stocks

Tracks stocks held in portfolios.

| Column       | Type                     | Notes                         |
| ------------ | ------------------------ | ----------------------------- |
| portfolio_id | INT                      | FK → Portfolios(portfolio_id) |
| stock_id     | INT                      | FK → Stocks(stock_id)         |
| quantity     | INT                      | Number of shares              |
| avg_price    | DECIMAL(10,2)            | Average purchase price        |
| **PK**       | (portfolio_id, stock_id) | Composite primary key         |

---

### 5. Transactions

Records buy/sell transactions.

| Column           | Type                                | Notes                         |
| ---------------- | ----------------------------------- | ----------------------------- |
| transaction_id   | INT AUTO_INCREMENT PRIMARY KEY      | Unique transaction ID         |
| portfolio_id     | INT                                 | FK → Portfolios(portfolio_id) |
| stock_id         | INT                                 | FK → Stocks(stock_id)         |
| transaction_type | ENUM('BUY','SELL')                  | Type of transaction           |
| quantity         | INT                                 | Number of shares              |
| price            | DECIMAL(10,2)                       | Price per share               |
| transaction_time | TIMESTAMP DEFAULT CURRENT_TIMESTAMP | Transaction timestamp         |

---

### 6. Stock_Prices

Stores historical stock prices.

| Column     | Type                   | Notes                 |
| ---------- | ---------------------- | --------------------- |
| stock_id   | INT                    | FK → Stocks(stock_id) |
| price      | DECIMAL(10,2)          | Stock price           |
| price_date | DATETIME               | Timestamp             |
| **PK**     | (stock_id, price_date) | Composite primary key |

---

### 7. Dividends

Records dividend payouts.

| Column        | Type                           | Notes                 |
| ------------- | ------------------------------ | --------------------- |
| dividend_id   | INT AUTO_INCREMENT PRIMARY KEY | Unique ID             |
| stock_id      | INT                            | FK → Stocks(stock_id) |
| amount        | DECIMAL(10,2)                  | Dividend per share    |
| dividend_date | DATE                           | Payout date           |

---

### 8. Alerts

Tracks user-defined alerts.

| Column       | Type                           | Notes                   |
| ------------ | ------------------------------ | ----------------------- |
| alert_id     | INT AUTO_INCREMENT PRIMARY KEY | Unique alert ID         |
| user_id      | INT                            | FK → Users(user_id)     |
| stock_id     | INT                            | FK → Stocks(stock_id)   |
| target_price | DECIMAL(10,2)                  | Price threshold         |
| alert_type   | ENUM('ABOVE','BELOW')          | Alert type              |
| active       | BOOLEAN                        | Whether alert is active |

---

### 9. Watchlist

Tracks stocks watched by users.

| Column   | Type                | Notes                 |
| -------- | ------------------- | --------------------- |
| user_id  | INT                 | FK → Users(user_id)   |
| stock_id | INT                 | FK → Stocks(stock_id) |
| **PK**   | (user_id, stock_id) | Composite primary key |

---

### 10. Sectors

Stores stock market sectors.

| Column    | Type                           | Notes                          |
| --------- | ------------------------------ | ------------------------------ |
| sector_id | INT AUTO_INCREMENT PRIMARY KEY | Unique sector ID               |
| name      | VARCHAR(100) UNIQUE            | Sector name (e.g., Technology) |

---

### 11. Stock_Sectors

Associates stocks with sectors.

| Column    | Type                  | Notes                   |
| --------- | --------------------- | ----------------------- |
| stock_id  | INT                   | FK → Stocks(stock_id)   |
| sector_id | INT                   | FK → Sectors(sector_id) |
| **PK**    | (stock_id, sector_id) | Composite primary key   |

---

### 12. Settings

User notification preferences.

| Column              | Type            | Notes               |
| ------------------- | --------------- | ------------------- |
| user_id             | INT PRIMARY KEY | FK → Users(user_id) |
| email_notifications | BOOLEAN         | Email notifications |
| sms_notifications   | BOOLEAN         | SMS notifications   |

---

## Procedures & Functions

### Procedures

1. **execute_transaction(portfolio_id, stock_id, transaction_type, quantity, price)**

   * Handles buy/sell transactions.
   * Automatically updates Portfolio_Stocks quantity and average price.
   * Inserts record into Transactions table.

2. **insert_stock_price(stock_id, price)**

   * Updates Stocks.current_price.
   * Inserts a new entry into Stock_Prices.
   * Triggers any alerts if the updated price crosses thresholds.

3. **portfolio_value(portfolio_id)**

   * Calculates total value of a portfolio by summing (quantity × current_price) for all stocks.

---

### Functions

1. **get_avg_price(portfolio_id, stock_id)**

   * Returns the average purchase price for a stock in a portfolio.
   * Returns 0 if the stock is not found.

2. **has_stock(portfolio_id, stock_id)**

   * Returns 1 if the portfolio holds the stock, else 0.

3. **total_shares(portfolio_id)**

   * Returns total number of shares across all stocks in a portfolio.

---

### Triggers

1. **on_user_insert**

   * After inserting a new user, automatically creates a default Settings row.

2. **on_transaction_insert**

   * Updates Portfolio_Stocks after a new transaction to maintain correct holdings and average prices.

3. **on_stock_price_insert**

   * Updates Stocks.current_price when a new price is inserted into Stock_Prices.

---

## Backend Integration

### Stock Update Endpoint (PUT /stocks/{stock_id})

* Connected to insert_stock_price stored procedure.
* Updates current price, inserts into Stock_Prices, triggers alerts if thresholds crossed.

**Request Example:**

```
PUT /stocks/1?current_price=180
```

**Response Example:**

```json
{
  "message": "Stock price updated successfully.",
  "alerts_triggered": [
    "ALERT: Stock AAPL (ID=1) triggered alert at price 180.00"
  ]
}
```

---

### Function Router (/functions)

* `GET /functions/avg_price?portfolio_id=1&stock_id=1` → Calls get_avg_price
* `GET /functions/has_stock?portfolio_id=1&stock_id=2` → Calls has_stock
* `GET /functions/total_shares?portfolio_id=1` → Calls total_shares

Used for testing and debugging functions directly via API.

---

## Sample Inserts

```sql
-- Users
INSERT IGNORE INTO Users(name,email) VALUES
('Alice','alice@example.com'),
('Bob','bob@example.com'),
('Charlie','charlie@example.com'),
('David','david@example.com'),
('Eve','eve@example.com');

-- Stocks
INSERT IGNORE INTO Stocks(symbol, company_name, current_price) VALUES
('AAPL','Apple Inc.',150),
('GOOGL','Alphabet Inc.',2000),
('MSFT','Microsoft Corp.',300),
('AMZN','Amazon.com Inc.',3500),
('TSLA','Tesla Inc.',800);

-- Portfolios
INSERT IGNORE INTO Portfolios(user_id,name) VALUES
(1,'Alice Tech Portfolio'),
(2,'Bob Growth Portfolio'),
(3,'Charlie Value Portfolio'),
(4,'David AI Portfolio'),
(5,'Eve Green Portfolio');

-- Portfolio_Stocks
INSERT IGNORE INTO Portfolio_Stocks(portfolio_id, stock_id, quantity, avg_price) VALUES
(1,1,10,150),
(1,2,5,2000),
(2,2,20,2000),
(3,3,15,300),
(4,4,10,3500),
(5,5,8,800);
```

---

## Environment Setup

### Prerequisites

* MySQL 8.0+
* Python 3.10+
* FastAPI + Uvicorn
* MySQL Connector/PyMySQL

### Environment Variables

```
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=yourpassword
DB_NAME=stock_portfolio
```

### Run Backend

```bash
uvicorn main:app --reload
```

Swagger UI: [http://127.0.0.1:8000/docs](http://127.0.0.1:8000/docs)

---

## Testing via Swagger

### 1. Test User Auto Settings Trigger

**Endpoint:** `POST /users`

**Body:**

```json
{
  "name": "Frank",
  "email": "frank@example.com"
}
```

**Expected:**

* User inserted into Users table.
* Trigger creates default Settings row.

**Verify:**

```sql
SELECT * FROM Settings WHERE user_id = (SELECT user_id FROM Users WHERE email='frank@example.com');
```

---

### 2. Test Transaction Procedure

**Endpoint:** `POST /transactions`

**Body:**

```json
{
  "portfolio_id": 1,
  "stock_id": 1,
  "transaction_type": "BUY",
  "quantity": 5,
  "price": 160
}
```

**Expected:**

* Transaction recorded in Transactions table.
* Portfolio_Stocks updated with new quantity and average price.
* Trigger `on_transaction_insert` executed.

**Verify:**

```sql
SELECT * FROM Portfolio_Stocks WHERE portfolio_id=1 AND stock_id=1;
SELECT * FROM Transactions WHERE portfolio_id=1 AND stock_id=1 ORDER BY transaction_time DESC;
```

---

### 3. Test Stock Price Procedure

**Endpoint:** `PUT /stocks/1?current_price=200`

**Expected:**

* Stock current_price updated in Stocks table.
* Stock_Prices entry inserted.
* Any alerts triggered returned in response.

**Verify:**

```sql
SELECT current_price FROM Stocks WHERE stock_id=1;
SELECT * FROM Stock_Prices WHERE stock_id=1 ORDER BY price_date DESC;
```

---

### 4. Test Function Router

* `/functions/avg_price?portfolio_id=1&stock_id=1` → Returns average price.
* `/functions/has_stock?portfolio_id=1&stock_id=2` → Returns 1 if stock exists.
* `/functions/total_shares?portfolio_id=1` → Returns total shares.

---

## Summary

This project provides:

* Fully normalized stock portfolio database
* Automated transactions, pricing, and alerts
* Integrated backend procedures, functions, and triggers
* Full support for real-time updates and alert notifications
* Swagger-based manual testing for easy verification

---

# Backend Router SQL & Function Reference

## Users Router (`/users`)

| Method | Endpoint            | SQL / Procedure Called                                                       | Description                               |
| ------ | ------------------- | ---------------------------------------------------------------------------- | ----------------------------------------- |
| POST   | `/create`           | `INSERT INTO Users (name, email) VALUES (%s, %s)`                            | Creates a new user and returns `user_id`. |
| GET    | `/`                 | `SELECT * FROM Users`                                                        | Returns all users.                        |
| GET    | `/{user_id}`        | `SELECT * FROM Users WHERE user_id=%s`                                       | Returns single user by ID.                |
| PUT    | `/update/{user_id}` | `UPDATE Users SET name=%s, email=%s WHERE user_id=%s` (only fields provided) | Updates name/email of a user.             |
| DELETE | `/delete/{user_id}` | `DELETE FROM Users WHERE user_id=%s`                                         | Deletes the user.                         |

---

## Stocks Router (`/stocks`)

| Method | Endpoint                   | SQL / Procedure Called                                                         | Description                                                                   |
| ------ | -------------------------- | ------------------------------------------------------------------------------ | ----------------------------------------------------------------------------- |
| GET    | `/`                        | `SELECT * FROM Stocks`                                                         | Returns all stocks.                                                           |
| GET    | `/{stock_id}`              | `SELECT * FROM Stocks WHERE stock_id=%s`                                       | Returns single stock by ID.                                                   |
| POST   | `/`                        | `INSERT INTO Stocks (symbol, company_name, current_price) VALUES (%s, %s, %s)` | Adds a new stock.                                                             |
| PUT    | `/update-price/{stock_id}` | Calls stored procedure `insert_stock_price(stock_id, current_price)`           | Updates `Stocks.current_price`, inserts into `Stock_Prices`, triggers alerts. |
| DELETE | `/{stock_id}`              | `DELETE FROM Stocks WHERE stock_id=%s`                                         | Deletes a stock.                                                              |

---

## Portfolios Router (`/portfolios`)

| Method | Endpoint          | SQL / Procedure Called                                                                   | Description                     |
| ------ | ----------------- | ---------------------------------------------------------------------------------------- | ------------------------------- |
| GET    | `/`               | `SELECT * FROM Portfolios`                                                               | Returns all portfolios.         |
| GET    | `/{portfolio_id}` | `SELECT * FROM Portfolios WHERE portfolio_id=%s`                                         | Returns a single portfolio.     |
| POST   | `/`               | `INSERT INTO Portfolios (user_id, name) VALUES (%s, %s)`                                 | Creates a new portfolio.        |
| PUT    | `/{portfolio_id}` | `UPDATE Portfolios SET name=%s, user_id=%s WHERE portfolio_id=%s` (only fields provided) | Updates portfolio name or user. |
| DELETE | `/{portfolio_id}` | `DELETE FROM Portfolios WHERE portfolio_id=%s`                                           | Deletes the portfolio.          |

---

## Transactions Router (`/transactions`)

| Method | Endpoint            | SQL / Procedure Called                                                                                  | Description                                                                            |
| ------ | ------------------- | ------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------- |
| GET    | `/`                 | `SELECT * FROM Transactions`                                                                            | Returns all transactions.                                                              |
| GET    | `/{transaction_id}` | `SELECT * FROM Transactions WHERE transaction_id=%s`                                                    | Returns single transaction.                                                            |
| POST   | `/`                 | Calls stored procedure `execute_transaction(portfolio_id, stock_id, transaction_type, quantity, price)` | Handles BUY/SELL transaction, updates `Portfolio_Stocks`, inserts into `Transactions`. |
| DELETE | `/{transaction_id}` | `DELETE FROM Transactions WHERE transaction_id=%s`                                                      | Deletes a transaction.                                                                 |

---

## Portfolio Stocks Router (`/portfolio-stocks`)

| Method | Endpoint          | SQL / Procedure Called                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             | Description                                                          |
| ------ | ----------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------- |
| GET    | `/{portfolio_id}` | Complex aggregation query:<br>`sql<br>SELECT t.stock_id, s.symbol, s.company_name,<br>SUM(CASE WHEN t.transaction_type='BUY' THEN t.quantity WHEN t.transaction_type='SELL' THEN -t.quantity ELSE 0 END) AS quantity,<br>CASE WHEN SUM(CASE WHEN t.transaction_type='BUY' THEN t.quantity ELSE 0 END) = 0 THEN 0<br>ELSE SUM(CASE WHEN t.transaction_type='BUY' THEN t.quantity * t.price ELSE 0 END)/SUM(CASE WHEN t.transaction_type='BUY' THEN t.quantity ELSE 0 END) END AS avg_price<br>FROM Transactions t JOIN Stocks s ON t.stock_id = s.stock_id<br>WHERE t.portfolio_id=%s<br>GROUP BY t.stock_id HAVING quantity>0<br>` | Returns current holdings of a portfolio and average purchase prices. |

---

## Alerts Router (`/alerts`)

| Method | Endpoint                | SQL / Procedure Called                                                                                                                 | Description                                        |
| ------ | ----------------------- | -------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------- |
| POST   | `/`                     | `INSERT INTO Alerts (user_id, stock_id, target_price, alert_type, active) VALUES (%s, %s, %s, %s, %s)`                                 | Creates a new alert.                               |
| GET    | `/{user_id}`            | `SELECT * FROM Alerts WHERE user_id=%s`                                                                                                | Retrieves all alerts for a user.                   |
| PUT    | `/{user_id}/{stock_id}` | `UPDATE Alerts SET target_price=%s WHERE user_id=%s AND stock_id=%s`<br>`UPDATE Alerts SET active=%s WHERE user_id=%s AND stock_id=%s` | Updates target price or active status of an alert. |
| DELETE | `/{user_id}/{stock_id}` | `DELETE FROM Alerts WHERE user_id=%s AND stock_id=%s`                                                                                  | Deletes an alert.                                  |

---

## Functions Router (`/functions`)

| Method | Endpoint                               | SQL / Procedure Called         | Description                                               |
| ------ | -------------------------------------- | ------------------------------ | --------------------------------------------------------- |
| GET    | `/avg-price/{portfolio_id}/{stock_id}` | `SELECT get_avg_price(%s, %s)` | Returns average purchase price of a stock in a portfolio. |
| GET    | `/has-stock/{portfolio_id}/{stock_id}` | `SELECT has_stock(%s, %s)`     | Returns 1 if portfolio holds the stock, else 0.           |
| GET    | `/total-shares/{portfolio_id}`         | `SELECT total_shares(%s)`      | Returns total number of shares in a portfolio.            |

---

## Watchlist Router (`/watchlist`)

| Method | Endpoint                | SQL / Procedure Called                                      | Description                     |
| ------ | ----------------------- | ----------------------------------------------------------- | ------------------------------- |
| POST   | `/`                     | `INSERT INTO Watchlist (user_id, stock_id) VALUES (%s, %s)` | Adds a stock to user watchlist. |
| GET    | `/{user_id}`            | `SELECT * FROM Watchlist WHERE user_id=%s`                  | Retrieves watchlist for a user. |
| DELETE | `/{user_id}/{stock_id}` | `DELETE FROM Watchlist WHERE user_id=%s AND stock_id=%s`    | Removes stock from watchlist.   |


