INSERT INTO Users (name, email) VALUES
('Rohan Mehta', 'rohan@gmail.com'),
('Priya Sharma', 'priya@gmail.com'),
('Aarav Patel', 'aarav@gmail.com');

INSERT INTO Stocks (symbol, company_name, current_price) VALUES
('AAPL', 'Apple Inc.', 190.50),
('GOOG', 'Alphabet Inc.', 2800.75),
('TSLA', 'Tesla Inc.', 750.25),
('INFY', 'Infosys Ltd.', 1420.60);

INSERT INTO Portfolios (user_id, name) VALUES
(1, 'Rohan Growth Fund'),
(2, 'Priya Tech Portfolio'),
(3, 'Aarav Balanced Fund');

INSERT INTO Portfolio_Stocks VALUES
(1, 1, 10, 180.50),
(1, 3, 5, 720.00),
(2, 2, 2, 2700.00),
(3, 4, 15, 1350.00);

INSERT INTO Transactions (portfolio_id, stock_id, transaction_type, quantity, price) VALUES
(1, 1, 'BUY', 10, 180.50),
(1, 3, 'BUY', 5, 720.00),
(2, 2, 'BUY', 2, 2700.00);

INSERT INTO Stock_Prices VALUES
(1, 185.00, '2025-10-15 09:00:00'),
(1, 190.50, '2025-10-16 09:00:00'),
(2, 2800.75, '2025-10-16 09:00:00'),
(3, 750.25, '2025-10-16 09:00:00');

INSERT INTO Dividends (stock_id, amount, dividend_date) VALUES
(1, 0.85, '2025-07-15'),
(2, 1.20, '2025-06-10');

INSERT INTO Alerts (user_id, stock_id, target_price, alert_type, active) VALUES
(1, 1, 200.00, 'ABOVE', TRUE),
(2, 3, 700.00, 'BELOW', TRUE);

INSERT INTO Watchlist VALUES
(1, 2),
(2, 1),
(3, 4);

INSERT INTO Sectors (name) VALUES
('Technology'),
('Automotive'),
('Finance');

INSERT INTO Stock_Sectors VALUES
(1, 1),
(2, 1),
(3, 2),
(4, 1);

INSERT INTO Settings VALUES
(1, TRUE, FALSE),
(2, TRUE, TRUE),
(3, FALSE, TRUE);
