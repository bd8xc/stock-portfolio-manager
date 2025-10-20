-- USERS
CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- STOCKS
CREATE TABLE Stocks (
    stock_id INT AUTO_INCREMENT PRIMARY KEY,
    symbol VARCHAR(10) UNIQUE NOT NULL,
    company_name VARCHAR(100) NOT NULL,
    current_price DECIMAL(10,2)
);

-- PORTFOLIOS
CREATE TABLE Portfolios (
    portfolio_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    name VARCHAR(100),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- PORTFOLIO_STOCKS
CREATE TABLE Portfolio_Stocks (
    portfolio_id INT,
    stock_id INT,
    quantity INT,
    avg_price DECIMAL(10,2),
    PRIMARY KEY (portfolio_id, stock_id),
    FOREIGN KEY (portfolio_id) REFERENCES Portfolios(portfolio_id),
    FOREIGN KEY (stock_id) REFERENCES Stocks(stock_id)
);

-- TRANSACTIONS
CREATE TABLE Transactions (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    portfolio_id INT,
    stock_id INT,
    transaction_type ENUM('BUY', 'SELL'),
    quantity INT,
    price DECIMAL(10,2),
    transaction_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (portfolio_id) REFERENCES Portfolios(portfolio_id),
    FOREIGN KEY (stock_id) REFERENCES Stocks(stock_id)
);

-- STOCK_PRICES
CREATE TABLE Stock_Prices (
    stock_id INT,
    price DECIMAL(10,2),
    price_date DATETIME,
    PRIMARY KEY (stock_id, price_date),
    FOREIGN KEY (stock_id) REFERENCES Stocks(stock_id)
);

-- DIVIDENDS
CREATE TABLE Dividends (
    dividend_id INT AUTO_INCREMENT PRIMARY KEY,
    stock_id INT,
    amount DECIMAL(10,2),
    dividend_date DATE,
    FOREIGN KEY (stock_id) REFERENCES Stocks(stock_id)
);

-- ALERTS
CREATE TABLE Alerts (
    alert_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    stock_id INT,
    target_price DECIMAL(10,2),
    alert_type ENUM('ABOVE', 'BELOW'),
    active BOOLEAN,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (stock_id) REFERENCES Stocks(stock_id)
);

-- WATCHLIST
CREATE TABLE Watchlist (
    user_id INT,
    stock_id INT,
    PRIMARY KEY (user_id, stock_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (stock_id) REFERENCES Stocks(stock_id)
);

-- SECTORS
CREATE TABLE Sectors (
    sector_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) UNIQUE
);

-- STOCK_SECTORS
CREATE TABLE Stock_Sectors (
    stock_id INT,
    sector_id INT,
    PRIMARY KEY (stock_id, sector_id),
    FOREIGN KEY (stock_id) REFERENCES Stocks(stock_id),
    FOREIGN KEY (sector_id) REFERENCES Sectors(sector_id)
);

-- SETTINGS
CREATE TABLE Settings (
    user_id INT PRIMARY KEY,
    email_notifications BOOLEAN,
    sms_notifications BOOLEAN,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);
