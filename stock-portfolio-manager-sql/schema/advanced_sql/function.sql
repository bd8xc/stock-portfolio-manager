USE stock_portfolio_db;

CREATE FUNCTION GetStockAveragePrice(stockId INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE avg_price DECIMAL(10,2);
    SELECT AVG(price) INTO avg_price
    FROM Stock_Prices
    WHERE stock_id = stockId;
    RETURN avg_price;
END;
