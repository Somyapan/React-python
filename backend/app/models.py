from pydantic import BaseModel, EmailStr, Field
from typing import Optional


class StudentCreate(BaseModel):
    name: str = Field(..., min_length=1)
    email: EmailStr
    course: str
    age: int


class Student(StudentCreate):
    id: str