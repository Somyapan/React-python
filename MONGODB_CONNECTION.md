# 🔗 MongoDB Connection Setup (Updated)

## Your Connection Code

The application now uses **PyMongo 4.7** with `ServerApi v1` for the most stable and up-to-date connection.

### Updated Connection Details

```python
from pymongo.mongo_client import MongoClient
from pymongo.server_api import ServerApi

uri = "mongodb+srv://somyapan:<db_password>@cluster0.crptmms.mongodb.net/?appName=Cluster0"

client = MongoClient(
    uri,
    server_api=ServerApi('1'),
    serverSelectionTimeoutMS=5000,
    connectTimeoutMS=10000,
    socketTimeoutMS=10000,
)

# Verify connection
try:
    client.admin.command('ping')
    print("✅ Pinged your deployment. You successfully connected to MongoDB!")
except Exception as e:
    print(f"❌ Error: {e}")
```

## Your Cluster Details

```
Username: somyapan
Cluster: cluster0
Domain: crptmms.mongodb.net
App Name: Cluster0
Database: studentdb
```

## Connection String Format

```
mongodb+srv://somyapan:<PASSWORD>@cluster0.crptmms.mongodb.net/?appName=Cluster0
```

**Replace `<PASSWORD>` with your actual MongoDB password**

## Setting Up .env File

1. Open `.env` file in the project root:
   ```bash
   nano /home/somya/react-mongo/student-form-app/.env
   ```

2. Update the MONGO_URI:
   ```env
   MONGO_URI=mongodb+srv://somyapan:YOUR_PASSWORD@cluster0.crptmms.mongodb.net/?appName=Cluster0
   ```

3. Save the file (Ctrl+O, Enter, Ctrl+X)

## Features of New Connection

✅ **ServerApi v1** - Latest MongoDB Stable API  
✅ **PyMongo 4.7** - Latest driver version  
✅ **Timeout Settings** - Optimized for reliability
- `serverSelectionTimeoutMS=5000` - Wait 5 seconds to connect
- `connectTimeoutMS=10000` - Connection timeout  
- `socketTimeoutMS=10000` - Socket operations timeout

✅ **Automatic Ping** - Verifies connection on startup  
✅ **Error Handling** - Clear error messages  
✅ **Production Ready** - Recommended by MongoDB  

## Connection Flow

```
┌─────────────────────────┐
│  Your Application       │
└────────────┬────────────┘
             │
             ↓
┌──────────────────────────┐
│  MongoClient with        │
│  ServerApi('1')          │
└────────────┬─────────────┘
             │
             ↓
┌──────────────────────────┐
│  PyMongo 4.7 Driver      │
└────────────┬─────────────┘
             │
             ↓
┌──────────────────────────┐
│  MongoDB Atlas           │
│  cluster0                │
│  somyapan (user)         │
│  studentdb (database)    │
└──────────────────────────┘
```

## Testing Connection

Before running the full application, test your connection:

```bash
cd /home/somya/react-mongo/student-form-app

# Test with Python
python3 << 'EOF'
from pymongo.mongo_client import MongoClient
from pymongo.server_api import ServerApi
import os
from dotenv import load_dotenv

load_dotenv()
uri = os.getenv("MONGO_URI")

client = MongoClient(uri, server_api=ServerApi('1'))
try:
    client.admin.command('ping')
    print("✅ Connection successful!")
except Exception as e:
    print(f"❌ Error: {e}")
EOF
```

## Requirements.txt Update

The `requirements.txt` has been updated to:
```
pymongo[srv]==4.7.0
```

This ensures you're using the latest PyMongo version with SRV support for MongoDB Atlas.

## Docker Configuration

The Docker container will automatically:
1. Load the `.env` file
2. Read your MONGO_URI
3. Connect to MongoDB Atlas on startup
4. Show connection status

## Running the Application

Once .env is configured:

```bash
cd /home/somya/react-mongo/student-form-app
./start.sh
```

Monitor the logs for connection messages:
```bash
docker-compose logs -f backend
```

You should see:
```
✅ Successfully connected to MongoDB!
Uvicorn running on http://0.0.0.0:8000
```

## Troubleshooting

### Authentication Failed
```
❌ Error: authentication failed
```
- Verify username: `somyapan`
- Verify password is correct (check for special characters)
- Ensure user was created in MongoDB Atlas

### Connection Timeout
```
❌ Error: ServerSelectionTimeoutError
```
- Check internet connection
- Verify IP is whitelisted in MongoDB Atlas
- Check if MongoDB Atlas cluster is running
- Try increasing timeouts in database.py

### Database Not Found
```
This is normal - MongoDB creates it on first write
```

### Connection String Issues
- Don't include angle brackets: `<PASSWORD>`
- Use actual password in `.env`
- Keep `.env` out of git (already in .gitignore)

## Security Notes

⚠️ **Important:**
1. Never commit `.env` to git
2. Never share your connection string with password
3. Use `.env.example` as template
4. Change password if exposed
5. Whitelist specific IPs in production

## MongoDB Atlas IP Whitelist

Your cluster currently needs:
- Access List Entry: (from your MongoDB Atlas settings)
- Recommendation: Whitelist your development IP only
- For deployment: Add server IP to whitelist

## Next Steps

1. ✅ Update `.env` with your MONGO_URI
2. ✅ Run: `./start.sh`
3. ✅ Open: http://localhost:3000
4. ✅ Test form submission
5. ✅ Check data in MongoDB Atlas Collections

## Useful MongoDB Commands

```bash
# View collections in database
docker-compose exec backend python3 << 'EOF'
from app.database import students_collection
print(list(students_collection.find()))
EOF

# Count documents
docker-compose exec backend python3 << 'EOF'
from app.database import students_collection
print(f"Total students: {students_collection.count_documents({})}")
EOF
```

## Reference Links

- **MongoDB Atlas**: https://www.mongodb.com/cloud/atlas
- **PyMongo Docs**: https://pymongo.readthedocs.io/
- **ServerApi Docs**: https://www.mongodb.com/docs/manual/reference/stable-api/
- **Connection Troubleshooting**: https://docs.mongodb.com/drivers/pymongo/#troubleshooting

