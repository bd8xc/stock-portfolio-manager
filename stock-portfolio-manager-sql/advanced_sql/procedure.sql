CREATE PROCEDURE AddTransaction(
    IN p_portfolio_id INT,
    IN p_stock_id INT,
    IN p_quantity INT,
    IN p_price DECIMAL(10,2),
    IN p_type ENUM('BUY','SELL')
)
BEGIN
    INSERT INTO Transactions (portfolio_id, stock_id, quantity, price, transaction_type, transaction_time)
    VALUES (p_portfolio_id, p_stock_id, p_quantity, p_price, p_type, NOW());

    IF p_type = 'BUY' THEN
        UPDATE Portfolio_Stocks
        SET quantity = quantity + p_quantity
        WHERE portfolio_id = p_portfolio_id AND stock_id = p_stock_id;
    ELSE
        UPDATE Portfolio_Stocks
        SET quantity = quantity - p_quantity
        WHERE portfolio_id = p_portfolio_id AND stock_id = p_stock_id;
    END IF;
END;
