import os
from pymongo.mongo_client import MongoClient
from pymongo.server_api import ServerApi
from dotenv import load_dotenv

load_dotenv()

# Get MongoDB URI from environment variables
MONGO_URI = os.getenv(
    "MONGO_URI",
    "mongodb+srv://username:password@cluster0.xxxxx.mongodb.net/?appName=Cluster0"
)

# Create MongoDB client with ServerApi v1
try:
    client = MongoClient(
        MONGO_URI,
        server_api=ServerApi('1'),
        serverSelectionTimeoutMS=5000,
        connectTimeoutMS=10000,
        socketTimeoutMS=10000,
    )
    
    # Send a ping to confirm successful connection
    client.admin.command('ping')
    print("✅ Successfully connected to MongoDB!")
    
    # Get database and collection
    db = client["studentdb"]
    students_collection = db["students"]
    
except Exception as e:
    print(f"❌ MongoDB Connection Error: {e}")
    raise
finally:
    # Note: Keep connection alive for application lifetime
    pass