#!/bin/bash

# Stop and remove containers
docker-compose down

echo "✅ Containers stopped and removed"
echo ""
echo "To remove volumes (database data):"
echo "  docker-compose down -v"
