# 🗄️ MongoDB Atlas Setup Guide

## Step-by-Step Instructions

### 1️⃣ Create MongoDB Atlas Account

1. Go to [MongoDB Atlas](https://www.mongodb.com/cloud/atlas)
2. Click "Start Free" or "Sign Up"
3. Create account with email or Google/GitHub
4. Verify your email
5. Accept terms and create account

### 2️⃣ Create an Organization & Project

1. After login, you'll see the organization screen
2. Create a new organization (or use default)
3. Create a new project (name it "Student Form App")

### 3️⃣ Create a Cluster

1. Click "Create Deployment" or "Build a Database"
2. Choose **Free Tier** (M0 - perfect for development)
3. Select your preferred cloud provider (AWS, Google, or Azure)
4. Choose region closest to you
5. Click "Create Deployment"
6. Wait 2-3 minutes for cluster creation

### 4️⃣ Create Database User

1. Go to "Database Access" in left sidebar
2. Click "Add new database user"
3. Choose "Password" authentication method
4. Enter username (e.g., `student_user`)
5. Enter password (e.g., `SecurePass123!`)
6. **Save username and password - you'll need this!**
7. Click "Add User"

**Important:** 
- Username: `student_user`
- Password: `SecurePass123!` (use a strong password)

### 5️⃣ Whitelist Your IP Address

1. Go to "Network Access" in left sidebar
2. Click "Add IP Address"
3. Choose one option:
   - **Option A:** Add Current IP (if you're connecting from fixed IP)
   - **Option B:** Add `0.0.0.0/0` (allow all IPs - less secure but easier for development)
4. Click "Confirm"

### 6️⃣ Get Connection String

1. Go back to "Clusters" view
2. Click "Connect" button on your cluster
3. Choose "Connect your application"
4. Select "Python" and driver version "3.12 or later"
5. Copy the connection string

**Example Connection String:**
```
mongodb+srv://student_user:SecurePass123!@cluster0.xxxxx.mongodb.net/?retryWrites=true&w=majority
```

### 7️⃣ Update Your .env File

1. Open `.env` file in project root
2. Replace the `MONGO_URI` with your actual connection string:

```env
MONGO_URI=mongodb+srv://student_user:SecurePass123!@cluster0.xxxxx.mongodb.net/studentdb?retryWrites=true&w=majority
```

**Important:** Add `/studentdb` at the end (database name)

### 8️⃣ Verify Connection

Before running Docker, you can test connection:

```bash
# Install pymongo
pip install pymongo

# Test connection
python -c "from pymongo import MongoClient; MongoClient('mongodb+srv://student_user:SecurePass123!@cluster0.xxxxx.mongodb.net/studentdb').admin.command('ping'); print('✅ Connected!')"
```

---

## 🔐 Security Best Practices

1. **Never commit .env to git** ✅ (already in .gitignore)
2. **Use strong passwords** (mix of uppercase, lowercase, numbers, symbols)
3. **Whitelist specific IPs** in production (not 0.0.0.0/0)
4. **Enable IP access list** in Network Access
5. **Use environment variables** for sensitive data
6. **Rotate credentials regularly** in production

---

## 🆘 Troubleshooting

### Connection Refused
```
Error: connect ECONNREFUSED
```
- Check if your IP is whitelisted
- Verify MongoDB URI in .env
- Ensure cluster is running

### Authentication Failed
```
Error: authentication failed
```
- Verify username and password
- Check for special characters in password (URL encode if needed)
- Ensure user was created successfully

### Database Not Found
```
Error: namespace does not exist
```
- This is normal - MongoDB creates database on first write
- Make sure you append `/studentdb` to URI

### IP Whitelist Error
```
Error: IP not whitelisted
```
- Go to Network Access
- Add your current IP or 0.0.0.0/0
- Wait a minute for changes to take effect

---

## 📊 Monitoring Your Database

1. Go to Collections in your cluster
2. View data being inserted
3. Use MongoDB Atlas UI to browse documents
4. Monitor performance with Atlas Charts

---

## 💾 Backup & Export Data

To export your data:
1. Go to Clusters > Tools > Export Data
2. Choose format (JSON, CSV)
3. Download your backup

---

## 🗑️ Delete Data or Cluster

**⚠️ WARNING: This is irreversible!**

1. To delete database: Collections > Select database > Delete
2. To delete cluster: Cluster > ... menu > Delete Cluster

---

## 📞 Need Help?

- MongoDB Atlas Docs: https://docs.mongodb.com/atlas/
- MongoDB Community: https://www.mongodb.com/community/forums/
- Stack Overflow tag: `mongodb-atlas`

