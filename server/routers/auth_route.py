from fastapi import APIRouter, Depends, HTTPException
import jwt
from sqlalchemy.orm import Session
from pydantic import BaseModel
from fastapi.security import OAuth2PasswordBearer
from datetime import timedelta


from utils.auth_token import create_access_token
from utils.middleware import verify_access_token
oauth2_scheme = OAuth2PasswordBearer(tokenUrl="token")
from pydantic_schemas.auth_schema import LoginUserModel, SignupUserModel

from database import get_db

from models.user_model import User


from utils.hash_password import hash_password, verify_password

# Define the router
router = APIRouter()


# Endpoint to Add a New User
@router.post("/signup", status_code=201)
def create_user(user: SignupUserModel, db: Session = Depends(get_db)):
    exist_user = db.query(User).filter(User.email == user.email).first()
    if exist_user:
        raise HTTPException(400, "User already exists!")

    new_user = User(name=user.name, email=user.email, password=user.password)
    db.add(new_user)
    db.commit()
    db.refresh(new_user)
    print('hey dude')
    return new_user

# @router.post("/login", status_code = 200)
# def login(user: LoginUserModel, db: Session = Depends(get_db)):
#     # Query user by email
#     db_user = db.query(User).filter(User.email == user.email).first()

#     # If user does not exist or password is incorrect
#     if not db_user or not verify_password(user.password, db_user.password):
#         raise HTTPException(status_code=400, detail="Invalid Credentials!")
#     print("Stored Password Type:", type(db_user.password))
#     print("Stored Password Value:", db_user.password)
#     # Generate JWT token
#     token = create_access_token(db_user.id)

#     # Return token and user info
#     return {'token': token, 'user': db_user}
@router.post("/login", status_code=200)
def login(user: LoginUserModel, db: Session = Depends(get_db)):
    db_user = db.query(User).filter(User.email == user.email).first()

    if not db_user or user.password != db_user.password:
        raise HTTPException(status_code=400, detail="Invalid Credentials!")

    access_token_expires = timedelta(minutes=60)  # Token valid for 1 hour

    # Generate token
    token = create_access_token(db_user.id, expires_delta=access_token_expires)

    # Store token in database
    db_user.auth_token = token
    db.commit()  # Save to DB
    db.refresh(db_user)  # Ensure changes are reflected

    # Remove password from response for security
    user_data = {
        "id": db_user.id,
        "name": db_user.name,
        "email": db_user.email,
        "auth_token": db_user.auth_token,
    }

    return {"token": token, "user": user_data}


@router.post("/logout")
def logout():
    return {"message": "Logged out successfully"}

# Endpoint to Get a User by ID
@router.post("/logout")
def logout(token: str, db: Session = Depends(get_db)):
    user_id = verify_access_token(token)  # Decode token to get user ID

    if not user_id:
        raise HTTPException(status_code=401, detail="Invalid token")

    db_user = db.query(User).filter(User.id == user_id).first()
    
    if not db_user:
        raise HTTPException(status_code=404, detail="User not found")

    db_user.auth_token = None  # Remove token from database
    db.commit()

    return {"success": True, "message": "User logged out successfully"}