from datetime import datetime, timedelta
import jwt
from sqlalchemy.orm import Session
from models.user_model import User
from utils.secret_keys import SECRET_KEY

ACCESS_TOKEN_EXPIRE_MINUTES = 60  # 1-hour expiry
ALGORITHM = "HS256"

# ✅ Fix: Ensure `data` is a dictionary
def create_access_token(user_id: int, expires_delta: timedelta):
    to_encode = {"id": user_id}  # ✅ Convert int to dictionary
    expire = datetime.utcnow() + expires_delta  # ✅ Fix: Remove extra `datetime.datetime()`
    to_encode.update({"exp": expire})  # Add expiration

    return jwt.encode(to_encode, SECRET_KEY, algorithm=ALGORITHM)

# Function to store access token in database
def store_access_token(user: User, token: str, db: Session):
    user.auth_token = token
    db.commit()