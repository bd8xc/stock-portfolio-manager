# test_db.py
from database import get_connection

conn = get_connection()
if conn:
    print("Connection successful!")
    conn.close()
else:
    print("Connection failed!")
