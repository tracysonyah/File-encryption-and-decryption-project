#!/bin/bash

file="$2"
output_file=""

if [[ "$1" == "encrypt" ]]; then
    echo "Encrypting $file"
    output_file="encrypted_$file"
elif [[ "$1" == "decrypt" ]]; then
    echo "Decrypting $file"
    output_file="decrypted_$file"
else
    echo "Usage: $0 <encrypt/decrypt> <input_file>"
    exit 1
fi

if [ ! -f "$file" ]; then
    echo "Input file does not exist"
    exit 1
fi

while true; do
    read -p "Enter the password: " -s password
    echo

    if [[ ${#password} -ge 8 ]]; then
        echo "Password accepted"
        break
    else
        echo "Password should be at least 8 characters long"
    fi
done

function encrypt_file() {
    openssl enc -aes-256-cbc -salt -in "$file" -out "$output_file" -k "$password"
}

function decrypt_file() {
    openssl enc -d -aes-256-cbc -in "$file" -out "$output_file" -k "$password"
}

if [[ "$1" == "encrypt" ]]; then
    encrypt_file
    echo "File encrypted and saved as $output_file"
elif [[ "$1" == "decrypt" ]]; then
    decrypt_file
    echo "File decrypted and saved as $output_file"
fi

