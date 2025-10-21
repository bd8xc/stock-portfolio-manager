CREATE TRIGGER AfterTransactionInsert
AFTER INSERT ON Transactions
FOR EACH ROW
BEGIN
    IF NEW.quantity > 100 THEN
        INSERT INTO Alerts (user_id, stock_id, target_price, alert_type, active)
        VALUES (
            (SELECT user_id FROM Portfolios WHERE portfolio_id = NEW.portfolio_id),
            NEW.stock_id,
            0,
            'ABOVE',
            TRUE
        );
    END IF;
END;
