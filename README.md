# 📚 Student Form Application

A full-stack MERN-like application built with FastAPI (backend) and React (frontend), using MongoDB Atlas as the database.

## 📋 Project Structure

```
student-form-app/
├── backend/
│   ├── app/
│   │   ├── __init__.py
│   │   ├── database.py
│   │   ├── models.py
│   │   └── main.py
│   ├── Dockerfile
│   └── requirements.txt
├── frontend/
│   ├── src/
│   │   ├── main.jsx
│   │   └── App.jsx
│   ├── Dockerfile
│   ├── package.json
│   ├── vite.config.js
│   └── index.html
├── docker-compose.yml
├── .env
├── .env.example
└── .gitignore
```

## 🚀 Setup Instructions

### Step 1: Create MongoDB Atlas Account & Cluster

1. Go to [MongoDB Atlas](https://www.mongodb.com/cloud/atlas)
2. Sign up or log in to your account
3. Create a new project
4. Create a cluster (Free tier is available)
5. Wait for cluster to be created (2-3 minutes)

### Step 2: Get MongoDB Connection String

1. Click "Connect" on your cluster
2. Choose "Connect your application"
3. Select "Python" driver
4. Copy the connection string

**Example:** 
```
mongodb+srv://username:password@cluster0.xxxxx.mongodb.net/studentdb?retryWrites=true&w=majority
```

### Step 3: Configure Environment

1. Open `.env` file in project root
2. Replace the `MONGO_URI` with your actual connection string:

```env
MONGO_URI=mongodb+srv://your_username:your_password@your_cluster.mongodb.net/studentdb?retryWrites=true&w=majority
```

**Important:** 
- Replace `your_username` with your MongoDB Atlas username
- Replace `your_password` with your MongoDB Atlas password
- Replace `your_cluster` with your cluster name

### Step 4: Run with Docker Compose

```bash
cd /home/somya/react-mongo/student-form-app
docker-compose up --build
```

The application will be available at:
- **Frontend:** http://localhost:3000
- **Backend API:** http://localhost:8000
- **API Docs:** http://localhost:8000/docs

### Step 5: Test the Application

1. Open http://localhost:3000 in your browser
2. Fill in the student form
3. Click "Submit"
4. See your student appear in the list

## 🔧 API Endpoints

### Health Check
- `GET /health` - Returns `{"status": "ok"}`

### Students
- `GET /students` - List all students
- `POST /students` - Create a new student

**Student Object:**
```json
{
  "id": "string",
  "name": "string",
  "email": "string",
  "course": "string",
  "age": "integer"
}
```

## 📝 Technologies Used

**Backend:**
- FastAPI - Modern Python web framework
- Uvicorn - ASGI server
- PyMongo - MongoDB driver
- Pydantic - Data validation

**Frontend:**
- React 18 - UI library
- Vite - Build tool
- Fetch API - HTTP client

**Infrastructure:**
- Docker - Containerization
- Docker Compose - Multi-container orchestration
- MongoDB Atlas - Cloud database

## 🛠️ Development (Local)

### Backend Only

```bash
cd backend
pip install -r requirements.txt
python -m uvicorn app.main:app --reload
```

### Frontend Only

```bash
cd frontend
npm install
npm run dev
```

## 📌 Important Notes

1. **Keep `.env` secure** - Never commit it to git (it's in `.gitignore`)
2. **MongoDB Atlas IP Whitelist** - Add your IP to Atlas Network Access
3. **Connection String** - Must include username and password
4. **Database Name** - Must be `studentdb` (or change in code)

## 🐛 Troubleshooting

### MongoDB Connection Error
- Check if your IP is whitelisted in MongoDB Atlas
- Verify connection string in `.env`
- Ensure `pymongo[srv]` is installed

### Frontend Can't Connect to Backend
- Check if backend is running on port 8000
- Verify `VITE_API_BASE_URL` environment variable
- Check browser console for CORS errors

### Port Already in Use
- Backend: `lsof -i :8000` then kill the process
- Frontend: `lsof -i :5173` then kill the process

## 📚 Useful Commands

```bash
# View logs
docker-compose logs -f

# Stop containers
docker-compose down

# Remove volumes (delete database data)
docker-compose down -v

# Rebuild images
docker-compose build --no-cache

# Run specific service
docker-compose up backend
```

## 🎯 Next Steps

- Add DELETE and UPDATE endpoints
- Add user authentication
- Add form validation on frontend
- Add loading states and error handling
- Add pagination for student list
- Deploy to cloud (AWS, Heroku, etc.)

## 📧 Support

For issues or questions, check:
1. MongoDB Atlas documentation
2. FastAPI documentation
3. React documentation
4. Docker documentation
