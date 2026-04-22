#!/bin/bash
# Script de inicialización ERP-COMPACTO
echo "🚀 Iniciando ERP-COMPACTO..."
cp .env.example .env
docker-compose -f infrastructure/docker-compose.yml up -d
echo "⏳ Esperando base de datos..."
sleep 5
psql -h localhost -U postgres -f database/migrations/001_initial_schema.sql
echo "✅ ERP-COMPACTO listo!"
