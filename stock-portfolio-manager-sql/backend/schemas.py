# backend/schemas.py
from pydantic import BaseModel
from typing import Optional
from datetime import datetime

# ---------- STOCK ----------
class StockBase(BaseModel):
    symbol: str
    company_name: str

class StockCreate(StockBase):
    pass

class Stock(StockBase):
    stock_id: int
    current_price: float

    class Config:
        orm_mode = True


# ---------- TRANSACTION ----------
class TransactionBase(BaseModel):
    portfolio_id: int
    stock_id: int
    quantity: int
    transaction_type: str  # BUY or SELL

class TransactionCreate(TransactionBase):
    pass

class Transaction(TransactionBase):
    transaction_id: int
    transaction_date: datetime

    class Config:
        orm_mode = True


# ---------- PORTFOLIO ----------
class PortfolioBase(BaseModel):
    user_id: int
    portfolio_name: str

class PortfolioCreate(PortfolioBase):
    pass

class Portfolio(PortfolioBase):
    portfolio_id: int
    created_at: datetime

    class Config:
        orm_mode = True
