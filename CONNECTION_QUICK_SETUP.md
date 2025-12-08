# 🔑 Your MongoDB Connection Details

## Quick Copy-Paste

**Username:** `somyapan`  
**Cluster:** `cluster0`  
**Domain:** `cluster0.crptmms.mongodb.net`  
**Database:** `studentdb`  
**App Name:** `Cluster0`  

## Connection String Template

```
mongodb+srv://somyapan:PASSWORD@cluster0.crptmms.mongodb.net/?appName=Cluster0
```

## Complete .env Configuration

Open `/home/somya/react-mongo/student-form-app/.env` and add:

```env
# MongoDB Atlas Connection
MONGO_URI=mongodb+srv://somyapan:YOUR_PASSWORD@cluster0.crptmms.mongodb.net/?appName=Cluster0

# Backend Configuration
BACKEND_HOST=0.0.0.0
BACKEND_PORT=8000

# Frontend Configuration
FRONTEND_HOST=0.0.0.0
FRONTEND_PORT=5173

# API Configuration
API_BASE_URL=http://localhost:8000
```

## Step-by-Step Setup

### 1. Get Your Password

From MongoDB Atlas:
1. Go to Database Users
2. Find user: `somyapan`
3. Click "Edit" or "Show"
4. Copy the password (or reset if forgotten)

### 2. Update .env File

```bash
nano /home/somya/react-mongo/student-form-app/.env
```

Replace `YOUR_PASSWORD` with your actual password (no brackets):

❌ **WRONG:** `mongodb+srv://somyapan:<PASSWORD>@cluster0...`  
✅ **RIGHT:** `mongodb+srv://somyapan:MySecurePass123@cluster0...`

### 3. Save and Close

- Press: Ctrl+O
- Press: Enter
- Press: Ctrl+X

### 4. Start Application

```bash
cd /home/somya/react-mongo/student-form-app
./start.sh
```

### 5. Monitor Connection

```bash
docker-compose logs -f backend
```

Look for: `✅ Successfully connected to MongoDB!`

## Test Connection

Before running full app:

```bash
cd /home/somya/react-mongo/student-form-app

python3 << 'EOF'
from pymongo.mongo_client import MongoClient
from pymongo.server_api import ServerApi

uri = "mongodb+srv://somyapan:YOUR_PASSWORD@cluster0.crptmms.mongodb.net/?appName=Cluster0"
client = MongoClient(uri, server_api=ServerApi('1'))

try:
    client.admin.command('ping')
    print("✅ MongoDB connection successful!")
except Exception as e:
    print(f"❌ Connection failed: {e}")
EOF
```

## Key Points

✅ **PyMongo Version:** 4.7.0  
✅ **MongoDB Stable API:** v1  
✅ **Connection Type:** MongoDB Atlas (SRV)  
✅ **Database:** studentdb  
✅ **Collections:** students  

## If You Forget Password

1. Go to MongoDB Atlas
2. Navigate to Database Access
3. Find user: `somyapan`
4. Click "..." menu
5. Select "Edit Password"
6. Set new password
7. Update `.env` file
8. Restart application

## Whitelist IP

Make sure your IP is whitelisted:

1. Go to MongoDB Atlas
2. Network Access
3. Add your current IP or `0.0.0.0/0` (for development)
4. Click "Confirm"
5. Wait 1-2 minutes for changes

## Common Issues & Solutions

| Issue | Solution |
|-------|----------|
| Connection refused | Check internet, verify IP whitelisted |
| Authentication failed | Verify password, no special char issues |
| Timeout | Increase timeout values in database.py |
| Database not found | Normal - creates on first write |

## Environment File Location

```
/home/somya/react-mongo/student-form-app/.env
```

## Files That Use This Connection

- `backend/app/database.py` - Reads MONGO_URI from .env
- `docker-compose.yml` - Passes MONGO_URI to container
- `start.sh` - Verifies .env exists

## Security Reminder

🔒 **Keep your .env file secure:**
- Never commit to git ✓ (already in .gitignore)
- Never share password ✓
- Don't put in screenshots ✓
- Rotate password periodically ✓

