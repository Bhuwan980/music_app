from fastapi import FastAPI
from database import Base, engine
from routers import auth

# Create the database tables
Base.metadata.create_all(bind=engine)

# Initialize FastAPI
app = FastAPI()

# Include the user router
app.include_router(auth.router, prefix="/users", tags=["users"])