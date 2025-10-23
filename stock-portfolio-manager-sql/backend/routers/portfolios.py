from fastapi import APIRouter
from pydantic import BaseModel
from database import get_connection

router = APIRouter(prefix="/portfolios", tags=["Portfolios"])

class PortfolioCreate(BaseModel):
    user_id: int
    name: str

# GET all portfolios
@router.get("/")
def get_portfolios():
    conn = get_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM Portfolios")
    portfolios = cursor.fetchall()
    conn.close()
    return portfolios

# POST: Create a new portfolio
@router.post("/")
def create_portfolio(portfolio: PortfolioCreate):
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute(
        "INSERT INTO Portfolios (user_id, name) VALUES (%s, %s)",
        (portfolio.user_id, portfolio.name)
    )
    conn.commit()
    conn.close()
    return {"message": f"Portfolio '{portfolio.name}' created successfully."}

# GET portfolio with stocks
@router.get("/{portfolio_id}")
def get_portfolio_with_stocks(portfolio_id: int):
    conn = get_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("""
        SELECT ps.portfolio_id, s.stock_id, s.symbol, s.company_name, ps.quantity, ps.avg_price
        FROM Portfolio_Stocks ps
        JOIN Stocks s ON ps.stock_id = s.stock_id
        WHERE ps.portfolio_id = %s
    """, (portfolio_id,))
    result = cursor.fetchall()
    conn.close()
    return result
