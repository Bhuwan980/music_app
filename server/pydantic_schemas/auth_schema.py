# Define a Database Model
from sqlalchemy import Column, Integer, String
from database import Base
from pydantic import BaseModel


class LoginUserModel(BaseModel):
    email: str
    password: str

class SignupUserModel(BaseModel):
    name: str
    email: str
    password: str
    