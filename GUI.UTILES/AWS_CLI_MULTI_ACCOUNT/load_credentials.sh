#!/bin/bash

CREDENTIALS_FILE="credentials.csv"
if [[ -f "$CREDENTIALS_FILE" ]]; then
  IFS= read -r AWS_ACCESS_KEY_ID < "$CREDENTIALS_FILE"
  IFS= read -r AWS_SECRET_ACCESS_KEY <&3
  IFS= read -r AWS_SESSION_TOKEN <&3

  export AWS_ACCESS_KEY_ID
  export AWS_SECRET_ACCESS_KEY
  export AWS_SESSION_TOKEN
else
  echo "El archivo de credenciales no existe o no se puede leer."
  exit 1
fi