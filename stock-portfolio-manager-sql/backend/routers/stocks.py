from fastapi import APIRouter
from pydantic import BaseModel
from database import get_connection

router = APIRouter(prefix="/stocks", tags=["Stocks"])

# Pydantic model for adding/updating stocks
class Stock(BaseModel):
    symbol: str
    company_name: str
    current_price: float

class StockPriceUpdate(BaseModel):
    current_price: float

# GET all stocks
@router.get("/")
def get_stocks():
    conn = get_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM Stocks")
    stocks = cursor.fetchall()
    conn.close()
    return stocks

# POST: Add a new stock
@router.post("/")
def add_stock(stock: Stock):
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute(
        "INSERT INTO Stocks (symbol, company_name, current_price) VALUES (%s, %s, %s)",
        (stock.symbol, stock.company_name, stock.current_price)
    )
    conn.commit()
    conn.close()
    return {"message": f"Stock {stock.symbol} added successfully."}

# PUT: Update stock price
@router.put("/{stock_id}")
def update_stock_price(stock_id: int, update: StockPriceUpdate):
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute(
        "UPDATE Stocks SET current_price = %s WHERE stock_id = %s",
        (update.current_price, stock_id)
    )
    conn.commit()
    conn.close()
    return {"message": f"Stock ID {stock_id} price updated to {update.current_price}."}
