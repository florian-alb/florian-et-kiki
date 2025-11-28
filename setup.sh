#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}╔════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║   🚀 Setup Microservices Architecture     ║${NC}"
echo -e "${BLUE}╔════════════════════════════════════════════╗${NC}"
echo ""

# Check if pnpm is installed
if ! command -v pnpm &> /dev/null; then
    echo -e "${RED}❌ pnpm is not installed!${NC}"
    echo -e "${YELLOW}Install it with: npm install -g pnpm${NC}"
    exit 1
fi

echo -e "${GREEN}✅ pnpm is installed${NC}"
echo ""

# Function to create .env files
create_env_files() {
    echo -e "${BLUE}📝 Creating environment files...${NC}"
    
    # Root .env for Docker Compose
    if [ ! -f ".env" ]; then
        if [ -f "env.example" ]; then
            cp env.example .env
            echo -e "${GREEN}  ✓ Created .env from env.example (for Docker Compose)${NC}"
        else
            echo -e "${RED}  ❌ env.example not found!${NC}"
            exit 1
        fi
    else
        echo -e "${YELLOW}  ⚠ .env already exists, skipping${NC}"
    fi
    
    # API Gateway .env
    if [ ! -f "backend/api-gateway/.env" ]; then
        cat > backend/api-gateway/.env << 'EOF'
# API Gateway Configuration
PORT=3000

# Microservices URLs (for Docker)
GENERATIONS_API_URL=http://generations-api:5002
USERS_API_URL=http://users-api:5001

# For local development without Docker, use:
# GENERATIONS_API_URL=http://localhost:5002
# USERS_API_URL=http://localhost:5001
EOF
        echo -e "${GREEN}  ✓ Created backend/api-gateway/.env${NC}"
    else
        echo -e "${YELLOW}  ⚠ backend/api-gateway/.env already exists, skipping${NC}"
    fi

    # Generations API .env
    if [ ! -f "backend/generations-api/.env" ]; then
        cat > backend/generations-api/.env << 'EOF'
# Generations API Configuration
PORT=5002

# MongoDB Configuration (for Docker)
MONGO_URI=mongodb://mongo:27017/generations-db

# For local development without Docker, use:
# MONGO_URI=mongodb://localhost:27017/generations-db
EOF
        echo -e "${GREEN}  ✓ Created backend/generations-api/.env${NC}"
    else
        echo -e "${YELLOW}  ⚠ backend/generations-api/.env already exists, skipping${NC}"
    fi

    # Users API .env
    if [ ! -f "backend/users-api/.env" ]; then
        cat > backend/users-api/.env << 'EOF'
# Users API Configuration
PORT=5001
EOF
        echo -e "${GREEN}  ✓ Created backend/users-api/.env${NC}"
    else
        echo -e "${YELLOW}  ⚠ backend/users-api/.env already exists, skipping${NC}"
    fi
    
    echo ""
}

# Function to install dependencies
install_dependencies() {
    echo -e "${BLUE}📦 Installing dependencies...${NC}"
    echo ""
    
    # API Gateway
    echo -e "${YELLOW}Installing api-gateway dependencies...${NC}"
    cd backend/api-gateway && pnpm install && cd ../..
    echo -e "${GREEN}  ✓ api-gateway dependencies installed${NC}"
    echo ""
    
    # Generations API
    echo -e "${YELLOW}Installing generations-api dependencies...${NC}"
    cd backend/generations-api && pnpm install && cd ../..
    echo -e "${GREEN}  ✓ generations-api dependencies installed${NC}"
    echo ""
    
    # Users API
    echo -e "${YELLOW}Installing users-api dependencies...${NC}"
    cd backend/users-api && pnpm install && cd ../..
    echo -e "${GREEN}  ✓ users-api dependencies installed${NC}"
    echo ""
}

# Main setup
create_env_files
install_dependencies

echo -e "${GREEN}╔════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║   ✅ Setup completed successfully!         ║${NC}"
echo -e "${GREEN}╚════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${BLUE}Next steps:${NC}"
echo ""
echo -e "${YELLOW}For Docker development:${NC}"
echo -e "  docker-compose up --build"
echo ""
echo -e "${YELLOW}For local development (3 terminals):${NC}"
echo -e "  Terminal 1: cd backend/api-gateway && pnpm dev"
echo -e "  Terminal 2: cd backend/generations-api && pnpm dev"
echo -e "  Terminal 3: cd backend/users-api && pnpm dev"
echo ""
echo -e "${YELLOW}MongoDB GUI:${NC}"
echo -e "  Use MongoDB Compass: mongodb://localhost:27017"
echo ""
echo -e "${BLUE}Access points:${NC}"
echo -e "  API Gateway:       http://localhost:3000"
echo -e "  Generations API:   http://localhost:5002"
echo -e "  Users API:         http://localhost:5001"
echo -e "  MongoDB:           mongodb://localhost:27017"
echo ""

