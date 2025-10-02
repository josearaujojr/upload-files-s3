#!/bin/sh
validate_file() {
  local file_path="$1"
  if [ -f "$file_path" ]; then
    return 0
  else
    echo "Arquivo não encontrado: $file_path"
    return 1
  fi
}

compress_file() {
  local input="$1"
  local output="$2"

  if gzip -c "$input" > "$output"; then
    echo "Arquivo comprimido: $input -> $output"
  else
    echo "Erro ao comprimir $input"
    return 1
  fi
}