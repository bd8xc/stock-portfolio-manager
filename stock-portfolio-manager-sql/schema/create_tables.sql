CREATE DATABASE IF NOT EXISTS stock_portfolio_manager;
USE stock_portfolio_manager;

CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Stocks (
    stock_id INT AUTO_INCREMENT PRIMARY KEY,
    symbol VARCHAR(10) UNIQUE NOT NULL,
    company_name VARCHAR(100) NOT NULL,
    current_price DECIMAL(10,2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Portfolios (
    portfolio_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

CREATE TABLE Portfolio_Stocks (
    portfolio_stock_id INT AUTO_INCREMENT PRIMARY KEY,
    portfolio_id INT NOT NULL,
    stock_id INT NOT NULL,
    quantity INT NOT NULL,
    avg_price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (portfolio_id) REFERENCES Portfolios(portfolio_id) ON DELETE CASCADE,
    FOREIGN KEY (stock_id) REFERENCES Stocks(stock_id) ON DELETE CASCADE
);

CREATE TABLE Transactions (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    portfolio_id INT NOT NULL,
    stock_id INT NOT NULL,
    transaction_type ENUM('BUY','SELL') NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    transaction_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (portfolio_id) REFERENCES Portfolios(portfolio_id),
    FOREIGN KEY (stock_id) REFERENCES Stocks(stock_id)
);

CREATE TABLE Stock_Prices (
    price_id INT AUTO_INCREMENT PRIMARY KEY,
    stock_id INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    price_date DATETIME NOT NULL,
    FOREIGN KEY (stock_id) REFERENCES Stocks(stock_id)
);

CREATE TABLE Dividends (
    dividend_id INT AUTO_INCREMENT PRIMARY KEY,
    stock_id INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    dividend_date DATE NOT NULL,
    FOREIGN KEY (stock_id) REFERENCES Stocks(stock_id)
);

CREATE TABLE Alerts (
    alert_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    stock_id INT NOT NULL,
    target_price DECIMAL(10,2) NOT NULL,
    alert_type ENUM('ABOVE','BELOW') NOT NULL,
    active BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (stock_id) REFERENCES Stocks(stock_id)
);

CREATE TABLE Watchlist (
    watchlist_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    stock_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (stock_id) REFERENCES Stocks(stock_id)
);

CREATE TABLE Sectors (
    sector_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE Stock_Sectors (
    stock_sector_id INT AUTO_INCREMENT PRIMARY KEY,
    stock_id INT NOT NULL,
    sector_id INT NOT NULL,
    FOREIGN KEY (stock_id) REFERENCES Stocks(stock_id),
    FOREIGN KEY (sector_id) REFERENCES Sectors(sector_id)
);

CREATE TABLE Settings (
    setting_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    email_notifications BOOLEAN DEFAULT TRUE,
    sms_notifications BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);
