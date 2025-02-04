from fastapi import APIRouter, Depends, HTTPException
import jwt
from sqlalchemy.orm import Session
from pydantic import BaseModel
from fastapi.security import OAuth2PasswordBearer
oauth2_scheme = OAuth2PasswordBearer(tokenUrl="token")
from pydantic_schemas.auth import LoginUserModel, SignupUserModel

from database import get_db

from models.create_user import User


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

# Endpoint to Get All Users
@router.post("/login")
def login(user: LoginUserModel, db: Session = Depends(get_db)):
    # Query the user by email
    #db_user = db.query(User).filter(User.email == user.email and User.password == user.password).first()
    db_user = db.query(User).filter((User.email == user.email) & (User.password == user.password)).first()
    # If the user doesn't exist or the password is incorrect
    if not db_user: #or not verify_password(db_user.password, user.password):
        raise HTTPException(status_code=400, detail="Invalid Credentials!")

    token = jwt.encode({'id': db_user.id}, 'secret_key')
    print(token)
    return {'token': token, 'user': db_user}


@router.post("/logout")
def logout():
    return {"message": "Logged out successfully"}

# Endpoint to Get a User by ID
@router.get("/{user_id}")
def get_user(user_id: int, db: Session = Depends(get_db)):
    user = db.query(User).filter(User.id == user_id).first()
    if not user:
        raise HTTPException(404, "User not found")
    return user