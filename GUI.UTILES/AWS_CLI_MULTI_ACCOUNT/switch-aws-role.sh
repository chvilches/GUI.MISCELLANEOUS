#!/bin/bash

# Script by Christian Vilches, Site Reliability Engineer

source ./load_credentials.sh

declare -A account_roles=(
  ["PRODUCTION"]="arn:aws:iam::1*******2:role/Adm*AccountAccessRole"
  ["DEVELOP"]="arn:aws:iam::2*******4:role/Adm*AccountAccessRole"
)

assume_role() {
  role_arn=$1
  role_session_name="SSMSession-$account_name"

  temp_role=$(aws sts assume-role \
                    --role-arn "$role_arn" \
                    --role-session-name "$role_session_name")

  export AWS_ACCESS_KEY_ID=$(echo $temp_role | jq -r .Credentials.AccessKeyId)
  export AWS_SECRET_ACCESS_KEY=$(echo $temp_role | jq -r .Credentials.SecretAccessKey)
  export AWS_SESSION_TOKEN=$(echo $temp_role | jq -r .Credentials.SessionToken)

  echo "Ahora estás en la sesión de la cuenta $account_name con el rol $role_session_name"
}

echo "Selecciona la cuenta de AWS en la que deseas trabajar:"
select account_name in "${!account_roles[@]}"; do
  role_arn=${account_roles[$account_name]}
  if [ -z "$account_name" ]; then
    account_name="DEVELOP"
    role_arn=${account_roles[$account_name]}
  fi
  assume_role $role_arn $account_name
  break
done

exec 3<&-


git clone repo
cp credential.example.csv credential.csv 