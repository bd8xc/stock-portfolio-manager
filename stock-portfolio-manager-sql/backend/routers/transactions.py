from fastapi import APIRouter
from pydantic import BaseModel
from database import get_connection

router = APIRouter(prefix="/transactions", tags=["Transactions"])

class Transaction(BaseModel):
    portfolio_id: int
    stock_id: int
    quantity: int
    price: float
    transaction_type: str  # "BUY" or "SELL"

# GET all transactions
@router.get("/")
def get_transactions():
    conn = get_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM Transactions")
    transactions = cursor.fetchall()
    conn.close()
    return transactions

# POST: Add transaction (call procedure)
@router.post("/")
def add_transaction(tx: Transaction):
    conn = get_connection()
    cursor = conn.cursor()
    cursor.callproc("AddTransaction", [
        tx.portfolio_id, tx.stock_id, tx.quantity, tx.price, tx.transaction_type
    ])
    conn.commit()
    conn.close()
    return {"message": "Transaction added successfully"}
