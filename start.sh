#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}"
echo "╔════════════════════════════════════════╗"
echo "║   Student Form App - Docker Startup    ║"
echo "╚════════════════════════════════════════╝"
echo -e "${NC}"

# Check if .env exists
if [ ! -f ".env" ]; then
    echo -e "${YELLOW}⚠️  .env file not found!${NC}"
    echo "Creating .env from .env.example..."
    if [ -f ".env.example" ]; then
        cp .env.example .env
        echo -e "${GREEN}✅ .env created${NC}"
        echo -e "${RED}❌ Please update MONGO_URI in .env with your MongoDB Atlas connection string${NC}"
        exit 1
    fi
fi

# Check if MONGO_URI is set
if ! grep -q "mongodb+srv://[^<]" .env; then
    echo -e "${RED}❌ MONGO_URI not configured in .env${NC}"
    echo -e "${YELLOW}Please update .env with your MongoDB Atlas connection string${NC}"
    echo "See MONGODB_SETUP.md for instructions"
    exit 1
fi

echo -e "${BLUE}📋 Checking Docker...${NC}"
if ! command -v docker &> /dev/null; then
    echo -e "${RED}❌ Docker not installed${NC}"
    echo "Install from: https://www.docker.com/products/docker-desktop"
    exit 1
fi
echo -e "${GREEN}✅ Docker found${NC}"

echo -e "\n${BLUE}📋 Checking Docker Compose...${NC}"
if ! command -v docker-compose &> /dev/null; then
    echo -e "${RED}❌ Docker Compose not installed${NC}"
    exit 1
fi
echo -e "${GREEN}✅ Docker Compose found${NC}"

echo -e "\n${BLUE}🔨 Building Docker images...${NC}"
docker-compose build

if [ $? -ne 0 ]; then
    echo -e "${RED}❌ Build failed${NC}"
    exit 1
fi

echo -e "\n${GREEN}✅ Build successful!${NC}"
echo -e "\n${BLUE}🚀 Starting containers...${NC}"
docker-compose up

