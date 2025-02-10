import bcrypt

# ✅ Hash a password before storing
def hash_password(password: str) -> str:
    salt = bcrypt.gensalt()  # Generate a random salt
    hashed_password = bcrypt.hashpw(password.encode('utf-8'), salt)
    return hashed_password.decode('utf-8')  # Store as a string in DB

# ✅ Verify a password
def verify_password(password_to_check: str, stored_password: str) -> bool:
    if isinstance(stored_password, str):  # Convert stored password to bytes
        stored_password = stored_password.encode('utf-8')
    
    return bcrypt.checkpw(password_to_check.encode('utf-8'), stored_password)