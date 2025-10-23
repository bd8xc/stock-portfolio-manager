# backend/main.py
from fastapi import FastAPI
from routers import stocks, transactions, portfolios

# Create the FastAPI app
app = FastAPI(
    title="Stock Portfolio Manager API",
    version="1.0.0",
    description="A simple portfolio and stock tracker built using FastAPI + MySQL Connector"
)

# Register routers
app.include_router(stocks.router, prefix="/stocks", tags=["Stocks"])
app.include_router(transactions.router, prefix="/transactions", tags=["Transactions"])
app.include_router(portfolios.router, prefix="/portfolios", tags=["Portfolios"])

# Root endpoint
@app.get("/")
def root():
    return {"message": "Stock Portfolio Manager API is running!"}
