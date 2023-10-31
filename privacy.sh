#!/bin/bash

file="$1"
#awk '{print $0}' "$file"

if [[ "$file" == *.* ]]
then
    echo "Okay"
else
    echo "A file with an extension must be given"
    exit
fi


while true;
do
    read -p "Enter a secure password: " password

    if [[ ${#password} -ge 8 ]]
    then
        echo "Wise choice"
        break
    else
        continue
    fi
done

function encrypt_file() {
    set -x
    encypt=$(openssl enc -aes-256-cbc -salt -in "$file" -out encrypted_"$file" -k "$password")
    #secure_password=(cat "$password" | tr -d '[:space:] [:punct:] [:.?!:]')
}
encrypt_file