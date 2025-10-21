CREATE OR REPLACE VIEW UserPortfolioSummary AS
SELECT 
    u.user_id,
    u.username,
    p.portfolio_id,
    p.portfolio_name,
    SUM(sp.current_price * ps.quantity) AS total_value
FROM Users u
JOIN Portfolios p ON u.user_id = p.user_id
JOIN Portfolio_Stocks ps ON p.portfolio_id = ps.portfolio_id
JOIN Stocks s ON ps.stock_id = s.stock_id
JOIN Stock_Prices sp ON s.stock_id = sp.stock_id
GROUP BY u.user_id, p.portfolio_id;
