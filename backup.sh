#!/bin/bash
# Backup de Supabase via pg_dump
# Requiere: brew install postgresql
# Uso: ./backup.sh TU_PASSWORD

if [ -z "$1" ]; then
  echo "Uso: ./backup.sh TU_PASSWORD"
  exit 1
fi

OUTPUT="backup_$(date +%Y%m%d_%H%M%S).sql"

echo "Conectando a Supabase..."
pg_dump "postgresql://postgres:$1@db.qpveivsqkudlqjbxcxzh.supabase.co:5432/postgres" \
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
