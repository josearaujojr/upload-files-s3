#!/bin/sh
s3_upload() {
  local file_path="$1"
  local key="$2"

  if aws s3 cp "$file_path" "s3://$S3_BUCKET/$key" --region "$AWS_REGION"; then
    echo "Upload concluído: $file_path -> s3://$S3_BUCKET/$key"
  else
    echo "Erro no upload de $file_path"
    return 1
  fi
}

s3_list() {
  local prefix="$1"
  aws s3 ls "s3://$S3_BUCKET/$prefix" --region "$AWS_REGION"
}