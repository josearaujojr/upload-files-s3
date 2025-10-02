#!/bin/sh
set -e

# import dos módulos
. ./1-config.sh
. ./2-file_utils.sh
. ./3-s3_utils.sh

FILES_DIR="./files"

echo "--- INICIANDO UPLOAD DE ARQUIVOS ---"

if [ ! -d "$FILES_DIR" ]; then
  echo "ERRO: Diretório $FILES_DIR não encontrado."
  exit 1
fi

for LOCAL_FILE in "$FILES_DIR"/*; do
  [ -e "$LOCAL_FILE" ] || continue

  case "$LOCAL_FILE" in
    *.gz) 
      echo "INFO: Ignorando arquivo já comprimido: $LOCAL_FILE"
      continue
      ;;
    *.txt)
      ;;
    *)
      echo "INFO: Ignorando tipo de arquivo não permitido: $LOCAL_FILE"
      continue
      ;;
  esac

  BASENAME=$(basename "$LOCAL_FILE")
  COMPRESSED_FILE="$FILES_DIR/$BASENAME.gz"
  S3_KEY="$UPLOAD_PREFIX/$BASENAME.gz"

  echo "PROCESSANDO: $LOCAL_FILE..."
  compress_file "$LOCAL_FILE" "$COMPRESSED_FILE"
  s3_upload "$COMPRESSED_FILE" "$S3_KEY"
done

echo "--- UPLOAD FINALIZADO ---"
echo "\n📂 Arquivos atuais no bucket:"
s3_list "$UPLOAD_PREFIX/"