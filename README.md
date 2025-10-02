# S3 File Uploader

Este projeto contém um conjunto de scripts shell para comprimir arquivos locais e fazer o upload para um bucket AWS S3.

## Funcionalidades

- Comprime arquivos usando `gzip`.
- Ignora arquivos que já estão comprimidos (extensão `.gz`).
- Faz upload dos arquivos comprimidos para um bucket S3 específico.
- Lista os arquivos no bucket após a conclusão do upload.
- O projeto é modular, separando configurações, utilitários de arquivo e operações S3.

## Estrutura do Projeto

```
./
├── 1-config.sh      # Variáveis de ambiente e configuração.
├── 2-file_utils.sh  # Funções para manipulação de arquivos (validar, comprimir).
├── 3-s3_utils.sh    # Funções para interação com o AWS S3 (upload, listar).
├── 4-main.sh        # Script principal que orquestra o processo.
└── files/           # Diretório onde os arquivos a serem processados devem estar.
```

## Pré-requisitos

- **Shell (sh)**: Compatível com o padrão POSIX.
- **AWS CLI**: Instalado e configurado com credenciais que tenham permissão para acessar o S3.
- **gzip**: Utilitário de compressão.

## Configuração

1.  **Configurar AWS CLI**:
    Certifique-se de que suas credenciais da AWS estão configuradas. Você pode fazer isso executando `aws configure`.

2.  **Variáveis de Ambiente**:
    O script utiliza variáveis de ambiente que podem ser definidas no arquivo `1-config.sh` ou exportadas no seu terminal antes da execução.

    - `AWS_REGION`: A região da AWS do seu bucket (padrão: `us-east-1`).
    - `S3_BUCKET`: O nome do seu bucket S3 (padrão: `testeupload00001`).
    - `UPLOAD_PREFIX`: O "diretório" dentro do bucket onde os arquivos serão enviados (padrão: `uploads`).

    Exemplo de como sobrescrever as variáveis no terminal:
    ```sh
    export S3_BUCKET="meu-bucket-de-producao"
    export AWS_REGION="sa-east-1"
    ```

## Como Usar

1.  **Adicione seus arquivos**:
    Coloque os arquivos que você deseja processar dentro do diretório `files/`.

2.  **Dê permissão de execução**:
    Certifique-se de que os scripts tenham permissão de execução.
    ```sh
    chmod +x *.sh
    ```

3.  **Execute o script principal**:
    Navegue até o diretório `bash/` e execute o script `4-main.sh`.
    ```sh
    ./4-main.sh
    ```

O script irá processar cada arquivo no diretório `files/`, comprimi-lo (se ainda não estiver), fazer o upload para o S3 e, ao final, listar os arquivos no bucket.
