-- =========================
-- 1️⃣ Execute transactions (will trigger Portfolio_Stocks updates)
-- =========================

-- Alice buys 5 more AAPL
CALL execute_transaction(1,1,'BUY',5,160);

-- Alice sells 3 GOOGL
CALL execute_transaction(1,2,'SELL',3,2050);

-- Bob buys 10 more GOOGL
CALL execute_transaction(2,2,'BUY',10,2100);

-- =========================
-- 2️⃣ Insert stock prices (will trigger current_price updates & alerts)
-- =========================

CALL insert_stock_price(1,158);   -- AAPL update
CALL insert_stock_price(2,2150);  -- GOOGL update, should trigger ABOVE alert
CALL insert_stock_price(2,1850);  -- GOOGL update, should trigger BELOW alert
CALL insert_stock_price(2,2000);  -- GOOGL update, no alert

-- =========================
-- 3️⃣ Test functions
-- =========================

-- Avg price of Alice's AAPL
SELECT get_avg_price(1,1) AS avg_price_aapl_alice;

-- Check if Alice has GOOGL
SELECT has_stock(1,2) AS alice_has_googl;

-- Check if Bob has GOOGL
SELECT has_stock(2,2) AS bob_has_googl;

-- Total shares in portfolios
SELECT total_shares(1) AS total_shares_alice;
SELECT total_shares(2) AS total_shares_bob;

-- =========================
-- 4️⃣ Portfolio value (procedure)
-- =========================
CALL portfolio_value(1);
CALL portfolio_value(2);

-- =========================
-- 5️⃣ Check resulting tables
-- =========================
SELECT * FROM Portfolio_Stocks;
SELECT * FROM Stock_Prices;
SELECT * FROM Alerts;
SELECT * FROM Stocks;
