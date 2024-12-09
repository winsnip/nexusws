#!/bin/bash

# Display logo
echo -e '\e[34m'
echo -e '██     ██ ██ ███    ██ ███████ ███    ██ ██ ██████  '
echo -e '██     ██ ██ ████   ██ ██      ████   ██ ██ ██   ██ '
echo -e '██  █  ██ ██ ██ ██  ██ ███████ ██ ██  ██ ██ ██████  '
echo -e '██ ███ ██ ██ ██  ██ ██      ██ ██  ██ ██ ██ ██      '
echo -e ' ███ ███  ██ ██   ████ ███████ ██   ████ ██ ██      '
echo -e '                                                   '
echo -e '\e[0m'
echo -e "Join our Telegram channel: https://t.me/winsnip"
echo ""

# Step 1: Update and upgrade system packages
echo "Updating system packages..."
sudo apt update && sudo apt upgrade -y

# Step 2: Install protobuf-compiler if not already installed
echo "Installing protobuf-compiler..."
sudo apt install -y protobuf-compiler

# Step 3: Install libssl-dev if not already installed
echo "Checking and installing libssl-dev..."
if ! dpkg -l | grep -q "libssl-dev"; then
    sudo apt install -y libssl-dev
else
    echo "libssl-dev is already installed."
fi

# Step 4: Ensure pkg-config is installed
echo "Checking and installing pkg-config..."
if ! command -v pkg-config &> /dev/null; then
    sudo apt install -y pkg-config
else
    echo "pkg-config is already installed."
fi

# Step 5: Check if OpenSSL is properly configured and install if missing
echo "Checking OpenSSL installation..."
if ! pkg-config --libs --cflags openssl &> /dev/null; then
    echo "OpenSSL is not properly installed. Installing OpenSSL..."
    sudo apt install -y openssl
fi

# Step 6: Install Rust and Cargo
echo "Checking and installing Rust and Cargo..."
if ! command -v cargo &> /dev/null; then
    echo "Cargo is not installed. Installing Rust and Cargo..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    source $HOME/.cargo/env
else
    echo "Cargo is already installed."
fi

# Step 7: Prompt for Prover ID
read -p "Please enter your Prover ID: " PROVER_ID
echo "$PROVER_ID" > ~/.nexus/prover-id

# Step 8: Install Nexus CLI
echo "Installing Nexus CLI..."
curl https://cli.nexus.xyz/ | sh

