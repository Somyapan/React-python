#!/bin/bash

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}   Student Form App - Setup Checker    ${NC}"
echo -e "${BLUE}========================================${NC}\n"

# Check if Docker is installed
echo -e "${YELLOW}1. Checking Docker installation...${NC}"
if command -v docker &> /dev/null; then
    echo -e "${GREEN}✅ Docker is installed${NC}"
else
    echo -e "${RED}❌ Docker is not installed${NC}"
    echo "   Install Docker from: https://www.docker.com/products/docker-desktop"
fi

# Check if Docker Compose is installed
echo -e "\n${YELLOW}2. Checking Docker Compose installation...${NC}"
if command -v docker-compose &> /dev/null; then
    echo -e "${GREEN}✅ Docker Compose is installed${NC}"
else
    echo -e "${RED}❌ Docker Compose is not installed${NC}"
fi

# Check if .env file exists
echo -e "\n${YELLOW}3. Checking .env file...${NC}"
if [ -f ".env" ]; then
    echo -e "${GREEN}✅ .env file exists${NC}"
    if grep -q "mongodb+srv://" .env; then
        echo -e "${GREEN}✅ MongoDB URI is configured${NC}"
    else
        echo -e "${YELLOW}⚠️  MongoDB URI may not be properly configured${NC}"
    fi
else
    echo -e "${YELLOW}⚠️  .env file not found (use .env.example as template)${NC}"
fi

# Check project structure
echo -e "\n${YELLOW}4. Checking project structure...${NC}"
declare -a files=(
    "backend/app/__init__.py"
    "backend/app/database.py"
    "backend/app/models.py"
    "backend/app/main.py"
    "backend/Dockerfile"
    "backend/requirements.txt"
    "frontend/src/App.jsx"
    "frontend/src/main.jsx"
    "frontend/Dockerfile"
    "frontend/package.json"
    "frontend/vite.config.js"
    "frontend/index.html"
    "docker-compose.yml"
)

for file in "${files[@]}"; do
    if [ -f "$file" ]; then
        echo -e "${GREEN}✅ $file${NC}"
    else
        echo -e "${RED}❌ $file (MISSING)${NC}"
    fi
done

echo -e "\n${BLUE}========================================${NC}"
echo -e "${GREEN}Setup check complete!${NC}"
echo -e "${BLUE}========================================${NC}\n"

echo -e "${YELLOW}Next Steps:${NC}"
echo "1. Get MongoDB Atlas connection string from: https://www.mongodb.com/cloud/atlas"
echo "2. Update MONGO_URI in .env file"
echo "3. Run: docker-compose up --build"
echo "4. Open http://localhost:3000 in browser"
echo ""
