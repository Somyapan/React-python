from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from bson import ObjectId
from typing import List

from .database import students_collection
from .models import StudentCreate, Student


app = FastAPI(title="Student Form API")

# CORS – allow React frontend on localhost:3000
origins = [
    "http://localhost:3000",
    "http://127.0.0.1:3000",
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


def student_to_dict(doc) -> Student:
    return Student(
        id=str(doc["_id"]),
        name=doc["name"],
        email=doc["email"],
        course=doc["course"],
        age=doc["age"],
    )


@app.get("/health")
def health():
    return {"status": "ok"}


@app.post("/students", response_model=Student)
def create_student(student: StudentCreate):
    result = students_collection.insert_one(student.dict())
    saved = students_collection.find_one({"_id": result.inserted_id})
    return student_to_dict(saved)


@app.get("/students", response_model=List[Student])
def list_students():
    docs = students_collection.find()
    return [student_to_dict(d) for d in docs]