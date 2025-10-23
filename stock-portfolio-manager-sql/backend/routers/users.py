from fastapi import APIRouter
from database import get_connection

router = APIRouter(prefix="/users", tags=["Users"])

@router.get("/")
def get_users():
    """
    Fetch all users from the database.
    """
    conn = get_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM Users")
    result = cursor.fetchall()
    conn.close()
    return result
