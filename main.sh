#!/bin/bash

# Function to install required packages
install_requirements() {
    echo -e "\033[1;34mChecking and installing required packages...\033[0m"
    packages=("jq" "perl" "xxd")
    for pkg in "${packages[@]}"; do
        if ! command -v $pkg &> /dev/null; then
            echo -e "\033[1;33m$pkg is not installed. Installing...\033[0m"
            if [[ "$OSTYPE" == "linux-gnu"* ]]; then
                sudo apt-get install -y $pkg
            elif [[ "$OSTYPE" == "darwin"* ]]; then
                brew install $pkg
            else
                echo -e "\033[1;31mUnsupported OS. Please install $pkg manually.\033[0m"
            fi
        else
            echo -e "\033[1;32m$pkg is already installed.\033[0m"
        fi
    done
}
# Function to perform leet speak transformation
leet_speak() {
    echo "$1" | sed 'y/aeiosAEIOS/43105@3105/'
}

# Function to perform ROT13 transformation

rot13() {
    echo "$1" | tr 'A-Za-z' 'N-ZA-Mn-za-m'
}

# Function to perform Base64 encoding
base64_encode() {
    echo "$1" | base64
}

# Function to perform Hexadecimal encoding
hex_encode() {
    echo -n "$1" | xxd -p | tr -d '\n'
    echo
}

# Function to perform URL encoding
url_encode() {
    echo -n "$1" | jq -sRr @uri
}

# Function to perform Unicode obfuscation
unicode_obfuscate() {
    echo "$1" | perl -CS -pe 's/([a-z])/sprintf("\\x{%04X}", ord($1) + 0xC0)/ge'
}

# Function to reverse the text
reverse_text() {
    echo "$1" | rev
}

# Function to perform Atbash cipher transformation
atbash_cipher() {
    echo "$1" | tr 'A-Za-z' 'ZYXWVUTSRQPONMLKJIHGFEDCBAzyxwvutsrqponmlkjihgfedcba'
}

# Function to display menu and get user's choice
show_menu() {
    echo -e "\033[1;34mChoose a transformation technique:\033[0m"
    echo -e "\033[1;32m1) Leet Speak"
    echo "2) ROT13"
    echo "3) Base64 Encoding"
    echo "4) Hexadecimal Encoding"
    echo "5) URL Encoding"
    echo "6) Unicode Obfuscation"
    echo "7) Reverse Text"
    echo "8) Atbash Cipher"
    echo -e "0) Exit\033[0m"
}

# Check for dependencies and install if needed
read -p $'\033[1;36mDo you want to check and install required packages? (y/n): \033[0m' install_choice
if [[ "$install_choice" == "y" || "$install_choice" == "Y" ]]; then
    install_requirements
fi

# Main script execution
while true; do
    read -p $'\033[1;36mEnter the text to transform: \033[0m' input_text

    if [ -z "$input_text" ]; then
        echo -e "\033[1;31mError: Input text cannot be empty. Please try again.\033[0m"
        continue
    fi

    while true; do
        show_menu
        read -p $'\033[1;36mEnter your choice (0-8): \033[0m' choice
        
        case $choice in
            1)
                transformed_text=$(leet_speak "$input_text")
                ;;
            2)
                transformed_text=$(rot13 "$input_text")
                ;;
            3)
                transformed_text=$(base64_encode "$input_text")
                ;;
            4)
                transformed_text=$(hex_encode "$input_text")
                ;;
            5)
                transformed_text=$(url_encode "$input_text")
                ;;
            6)
                transformed_text=$(unicode_obfuscate "$input_text")
                ;;
            7)
                transformed_text=$(reverse_text "$input_text")
                ;;
            8)
                transformed_text=$(atbash_cipher "$input_text")
                ;;
            0)
                echo -e "\033[1;34mExiting...\033[0m"
                exit 0
                ;;
            *)
                echo -e "\033[1;31mInvalid choice. Please try again.\033[0m"
                continue
                ;;
        esac
        break
    done

    echo -e "\033[1;32mTransformed text:\033[0m \033[1;33m$transformed_text\033[0m"
    echo -e "\033[1;34m------------------------------------\033[0m"

    read -p $'\033[1;36mDo you want to transform another text? (y/n): \033[0m' continue_choice
    if [[ "$continue_choice" != "y" && "$continue_choice" != "Y" ]]; then
        echo -e "\033[1;34mGoodbye!\033[0m"
        break
    fi
done
