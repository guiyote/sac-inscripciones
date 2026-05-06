#!/bin/bash
# Backup de Supabase via pg_dump
# Requiere: brew install postgresql
# Uso: ./backup.sh

read -s -p "Password de la base: " DB_PASSWORD
echo
BACKUP_DIR="/Users/gacosta/sac-inscripciones/backups"
OUTPUT="$BACKUP_DIR/backup_$(date +%Y%m%d_%H%M%S).sql"

mkdir -p "$BACKUP_DIR"

echo "Conectando a Supabase..."
pg_dump "postgresql://postgres.qpveivsqkudlqjbxcxzh:$DB_PASSWORD@aws-1-us-west-2.pooler.supabase.com:5432/postgres" \
  --no-owner \
  --no-acl \
  -f "$OUTPUT"

if [ $? -eq 0 ]; then
  echo "Backup guardado: $OUTPUT ($(du -h "$OUTPUT" | cut -f1))"
else
  echo "Error en el backup"
  rm -f "$OUTPUT"
  exit 1
fi
