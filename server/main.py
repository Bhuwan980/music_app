from fastapi import FastAPI
from database import Base, engine
from routers import auth_route

# Create the database tables
Base.metadata.create_all(bind=engine)

# Initialize FastAPI
app = FastAPI()

# Include the user router
app.include_router(auth_route.router, prefix="/users", tags=["users"])