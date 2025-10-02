#!/bin/sh
set -e

# import dos módulos
. ./1-config.sh
. ./2-file_utils.sh
. ./3-s3_utils.sh

FILES_DIR="./files"
UPLOAD_PREFIX="uploads"

echo "- INICIANDO UPLOAD DE ARQUIVOS...\n"

if [ ! -d "$FILES_DIR" ]; then
  echo "- ERRO Diretório $FILES_DIR não encontrado.\n"
  exit 1
fi

for LOCAL_FILE in "$FILES_DIR"/*; do
  case "$LOCAL_FILE" in
    *.gz) 
      echo "\n- IGNORANDO arquivo já comprimido: $LOCAL_FILE \n"
      continue
      ;;
  esac

  if validate_file "$LOCAL_FILE"; then
    BASENAME=$(basename "$LOCAL_FILE")
    COMPRESSED_FILE="$FILES_DIR/$BASENAME.gz"
    S3_KEY="$UPLOAD_PREFIX/$BASENAME.gz"

    echo "- PROCESSANDO $LOCAL_FILE ... \n"
    compress_file "$LOCAL_FILE" "$COMPRESSED_FILE"
    s3_upload "$COMPRESSED_FILE" "$S3_KEY"
  fi
done

echo "📂 Arquivos atuais no bucket:"
s3_list "$UPLOAD_PREFIX/"