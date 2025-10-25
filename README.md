# **Stock Portfolio Management Database — Complete Overview**
## **Abstract**

This database manages users, their stock portfolios, transactions, watchlists, and related stock market information.
It supports:

* Tracking real-time stock prices
* Dividend payouts
* Sector classification
* User alerts
* Personalized notification settings

Data integrity is enforced using **primary keys, foreign keys, unique constraints, and appropriate data types**.

---

## **Database Tables & Schema**

### **1. Users**

Stores system users.

| Column     | Type                                | Notes             |
| ---------- | ----------------------------------- | ----------------- |
| user_id    | INT AUTO_INCREMENT PRIMARY KEY      | Unique identifier |
| name       | VARCHAR(100) NOT NULL               | User's name       |
| email      | VARCHAR(100) UNIQUE NOT NULL        | User's email      |
| created_at | TIMESTAMP DEFAULT CURRENT_TIMESTAMP | Creation time     |

---

### **2. Stocks**

Details of available stocks.

| Column        | Type                           | Notes           |
| ------------- | ------------------------------ | --------------- |
| stock_id      | INT AUTO_INCREMENT PRIMARY KEY | Unique stock ID |
| symbol        | VARCHAR(10) UNIQUE NOT NULL    | Stock symbol    |
| company_name  | VARCHAR(100) NOT NULL          | Company name    |
| current_price | DECIMAL(10,2)                  | Latest price    |

---

### **3. Portfolios**

Represents user portfolios.

| Column       | Type                           | Notes               |
| ------------ | ------------------------------ | ------------------- |
| portfolio_id | INT AUTO_INCREMENT PRIMARY KEY | Portfolio ID        |
| user_id      | INT                            | FK → Users(user_id) |
| name         | VARCHAR(100)                   | Portfolio name      |

---

### **4. Portfolio_Stocks**

Tracks stocks held in portfolios.

| Column       | Type                     | Notes                         |
| ------------ | ------------------------ | ----------------------------- |
| portfolio_id | INT                      | FK → Portfolios(portfolio_id) |
| stock_id     | INT                      | FK → Stocks(stock_id)         |
| quantity     | INT                      | Number of shares              |
| avg_price    | DECIMAL(10,2)            | Average purchase price        |
| **PK**       | (portfolio_id, stock_id) | Composite primary key         |

---

### **5. Transactions**

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

### **6. Stock_Prices**

Stores historical stock prices.

| Column     | Type                   | Notes                 |
| ---------- | ---------------------- | --------------------- |
| stock_id   | INT                    | FK → Stocks(stock_id) |
| price      | DECIMAL(10,2)          | Stock price           |
| price_date | DATETIME               | Timestamp             |
| **PK**     | (stock_id, price_date) | Composite primary key |

---

### **7. Dividends**

Records dividend payouts.

| Column        | Type                           | Notes                 |
| ------------- | ------------------------------ | --------------------- |
| dividend_id   | INT AUTO_INCREMENT PRIMARY KEY | Unique ID             |
| stock_id      | INT                            | FK → Stocks(stock_id) |
| amount        | DECIMAL(10,2)                  | Dividend per share    |
| dividend_date | DATE                           | Payout date           |

---

### **8. Alerts**

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

### **9. Watchlist**

Tracks stocks watched by users.

| Column   | Type                | Notes                 |
| -------- | ------------------- | --------------------- |
| user_id  | INT                 | FK → Users(user_id)   |
| stock_id | INT                 | FK → Stocks(stock_id) |
| **PK**   | (user_id, stock_id) | Composite primary key |

---

### **10. Sectors**

Stores stock market sectors.

| Column    | Type                           | Notes                          |
| --------- | ------------------------------ | ------------------------------ |
| sector_id | INT AUTO_INCREMENT PRIMARY KEY | Unique sector ID               |
| name      | VARCHAR(100) UNIQUE            | Sector name (e.g., Technology) |

---

### **11. Stock_Sectors**

Associates stocks with sectors.

| Column    | Type                  | Notes                   |
| --------- | --------------------- | ----------------------- |
| stock_id  | INT                   | FK → Stocks(stock_id)   |
| sector_id | INT                   | FK → Sectors(sector_id) |
| **PK**    | (stock_id, sector_id) | Composite primary key   |

---

### **12. Settings**

User notification preferences.

| Column              | Type            | Notes               |
| ------------------- | --------------- | ------------------- |
| user_id             | INT PRIMARY KEY | FK → Users(user_id) |
| email_notifications | BOOLEAN         | Email notifications |
| sms_notifications   | BOOLEAN         | SMS notifications   |

---

## **Procedures & Functions Implemented**

1. **Procedures**

* `execute_transaction(portfolio_id, stock_id, transaction_type, quantity, price)`
  → Handles buy/sell and updates `Portfolio_Stocks` automatically.

* `insert_stock_price(stock_id, price)`
  → Updates `Stocks.current_price` and adds row in `Stock_Prices`; triggers alerts if thresholds crossed.

* `portfolio_value(portfolio_id)`
  → Returns total value of a portfolio using current stock prices.

2. **Functions**

* `get_avg_price(portfolio_id, stock_id)` → Returns average price of a stock in a portfolio.
* `has_stock(portfolio_id, stock_id)` → Returns 1 if the portfolio holds the stock, else 0.
* `total_shares(portfolio_id)` → Returns total shares in a portfolio.

3. **Triggers**

* On **Users insert** → Automatically populate default row in `Settings`.
* On **Transactions insert** → Update `Portfolio_Stocks` quantity & average price automatically.
* On **Stock_Prices insert** → Update `Stocks.current_price` automatically.

---

## **Sample Inserts (Base Data)**

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

-- Portfolio_Stocks (initial holdings)
INSERT IGNORE INTO Portfolio_Stocks(portfolio_id, stock_id, quantity, avg_price) VALUES
(1,1,10,150),
(1,2,5,2000),
(2,2,20,2000),
(3,3,15,300),
(4,4,10,3500),
(5,5,8,800);
```

