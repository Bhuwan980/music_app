import bcrypt

def hash_password(password: str) -> str:
    salt = bcrypt.gensalt()
    hashed_password = bcrypt.hashpw(password.encode('utf-8'), salt)
    return hashed_password.decode('utf-8')

def verify_password(stored_password: str, password_to_check: str) -> bool:
    return bcrypt.checkpw(password_to_check.encode('utf-8'), stored_password.encode('utf-8'))