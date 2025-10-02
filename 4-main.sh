#!/bin/sh
set -e

# import dos módulos
. ./1-config.sh
. ./2-file_utils.sh
. ./3-s3_utils.sh

LOCAL_FILE="data.txt"
COMPRESSED_FILE="data.txt.gz"
S3_KEY="$UPLOAD_PREFIX/$(basename "$COMPRESSED_FILE")"

echo "Iniciando processo..."

if validate_file "$LOCAL_FILE"; then
  compress_file "$LOCAL_FILE" "$COMPRESSED_FILE"
  s3_upload "$COMPRESSED_FILE" "$S3_KEY"
  echo "📂 Arquivos no bucket:"
  s3_list "$UPLOAD_PREFIX/"
else
  echo "Processo abortado: arquivo $LOCAL_FILE não existe."
fi