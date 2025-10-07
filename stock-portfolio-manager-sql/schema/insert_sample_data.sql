USE stock_portfolio_manager;

INSERT INTO Users (name, email) VALUES 
('Alice', 'alice@example.com'),
('Bob', 'bob@example.com'),
('Charlie', 'charlie@example.com'),
('David', 'david@example.com'),
('Eva', 'eva@example.com'),
('Frank', 'frank@example.com'),
('Grace', 'grace@example.com'),
('Hannah', 'hannah@example.com'),
('Ian', 'ian@example.com'),
('Judy', 'judy@example.com');

INSERT INTO Stocks (symbol, company_name, current_price) VALUES
('AAPL', 'Apple Inc.', 180.50),
('GOOG', 'Alphabet Inc.', 2800.75),
('TSLA', 'Tesla Inc.', 750.25),
('MSFT', 'Microsoft Corp.', 300.10),
('AMZN', 'Amazon.com Inc.', 3500.00),
('NFLX', 'Netflix Inc.', 500.25),
('FB', 'Meta Platforms Inc.', 330.50),
('NVDA', 'NVIDIA Corp.', 550.75),
('BABA', 'Alibaba Group', 200.10),
('ORCL', 'Oracle Corp.', 90.50);

INSERT INTO Portfolios (user_id, name) VALUES
(1, 'Tech Portfolio'),
(2, 'Growth Portfolio'),
(3, 'Dividend Portfolio'),
(4, 'Value Portfolio'),
(5, 'AI Portfolio'),
(6, 'E-Commerce Portfolio'),
(7, 'Crypto Portfolio'),
(8, 'ETF Portfolio'),
(9, 'Long Term Portfolio'),
(10, 'Short Term Portfolio');

INSERT INTO Portfolio_Stocks (portfolio_id, stock_id, quantity, avg_price) VALUES
(1, 1, 10, 175.00),
(1, 2, 5, 2750.00),
(2, 3, 8, 700.00),
(2, 4, 15, 290.00),
(3, 5, 12, 3400.00),
(3, 6, 7, 480.00),
(4, 7, 20, 320.00),
(5, 8, 25, 500.00),
(6, 9, 10, 190.00),
(7, 10, 30, 85.00);

INSERT INTO Transactions (portfolio_id, stock_id, transaction_type, quantity, price) VALUES
(1, 1, 'BUY', 10, 175.00),
(1, 2, 'BUY', 5, 2750.00),
(2, 3, 'BUY', 8, 700.00),
(2, 4, 'BUY', 15, 290.00),
(3, 5, 'BUY', 12, 3400.00),
(3, 6, 'BUY', 7, 480.00),
(4, 7, 'BUY', 20, 320.00),
(5, 8, 'BUY', 25, 500.00),
(6, 9, 'BUY', 10, 190.00),
(7, 10, 'BUY', 30, 85.00);

INSERT INTO Stock_Prices (stock_id, price, price_date) VALUES
(1, 180.50, '2025-10-07 09:00:00'),
(2, 2800.75, '2025-10-07 09:00:00'),
(3, 750.25, '2025-10-07 09:00:00'),
(4, 300.10, '2025-10-07 09:00:00'),
(5, 3500.00, '2025-10-07 09:00:00'),
(6, 500.25, '2025-10-07 09:00:00'),
(7, 330.50, '2025-10-07 09:00:00'),
(8, 550.75, '2025-10-07 09:00:00'),
(9, 200.10, '2025-10-07 09:00:00'),
(10, 90.50, '2025-10-07 09:00:00');

INSERT INTO Dividends (stock_id, amount, dividend_date) VALUES
(1, 0.82, '2025-09-15'),
(2, 0.00, '2025-09-15'),
(3, 0.00, '2025-09-15'),
(4, 0.56, '2025-09-15'),
(5, 0.00, '2025-09-15'),
(6, 0.45, '2025-09-15'),
(7, 0.50, '2025-09-15'),
(8, 0.60, '2025-09-15'),
(9, 0.30, '2025-09-15'),
(10, 0.40, '2025-09-15');

INSERT INTO Alerts (user_id, stock_id, target_price, alert_type, active) VALUES
(1, 1, 190.00, 'ABOVE', TRUE),
(2, 3, 720.00, 'ABOVE', TRUE),
(3, 5, 3550.00, 'ABOVE', TRUE),
(4, 2, 2700.00, 'BELOW', TRUE),
(5, 6, 520.00, 'ABOVE', TRUE),
(6, 7, 300.00, 'BELOW', TRUE),
(7, 8, 560.00, 'ABOVE', TRUE),
(8, 9, 210.00, 'ABOVE', TRUE),
(9, 10, 95.00, 'ABOVE', TRUE),
(10, 4, 280.00, 'BELOW', TRUE);

INSERT INTO Watchlist (user_id, stock_id) VALUES
(1, 5),
(2, 2),
(3, 1),
(4, 6),
(5, 7),
(6, 8),
(7, 9),
(8, 10),
(9, 3),
(10, 4);

INSERT INTO Sectors (name) VALUES
('Technology'),
('Automobile'),
('E-Commerce'),
('Streaming'),
('Social Media'),
('Semiconductors'),
('Retail'),
('Cloud'),
('Finance'),
('Energy');

INSERT INTO Stock_Sectors (stock_id, sector_id) VALUES
(1, 1),
(2, 1),
(3, 2),
(4, 1),
(5, 3),
(6, 4),
(7, 5),
(8, 6),
(9, 7),
(10, 8);

INSERT INTO Settings (user_id, email_notifications, sms_notifications) VALUES
(1, TRUE, FALSE),
(2, TRUE, TRUE),
(3, FALSE, TRUE),
(4, TRUE, FALSE),
(5, TRUE, TRUE),
(6, FALSE, FALSE),
(7, TRUE, TRUE),
(8, TRUE, FALSE),
(9, FALSE, TRUE),
(10, TRUE, TRUE);
