#!/bin/bash

# Mobile penetration test tools installation script.

# Change the URL to the latest version of Android Studio before running.
android_studio_url="https://redirector.gvt1.com/edgedl/android/studio/ide-zips/2024.2.1.12/android-studio-2024.2.1.12-linux.tar.gz"
current_user=$(whoami)
download_folder="/home/$current_user/Downloads"
home_folder="/home/$current_user"

red='\033[0;31m'
green='\033[0;32m'
clear='\033[0m'

echo -e "${red} This script requires root privileges. ${clear}"
echo -e "${red} DO NOT run the script as sudo directly. It may break the script. ${clear}"

# Update and download the tools required.
echo -e "${green} [+] Downloading the required tools... ${clear}"
sudo apt update && sudo apt install apktool docker.io android-sdk-platform-tools jadx burpsuite python3 -y
sudo pip3 install frida frida-tools objection

#Install Android Studio
echo -e "${green} [+] Downloading Android Studio. ${clear}"
wget -P $download_folder $android_studio_url
tar -xzvf "$download_folder/android-studio-2024.2.1.12-linux.tar.gz" -C $home_folder # Change the Android Studio name when updating the script.
echo -e "${green} [+] Download completed. It can be accessed from your home directory. Run with ./android-studio/bin/studio.sh ${clear}"

# Run Mob-SF using Docker.
echo -e "${green} [+] Running Mob-SF with Docker. ${clear}"
sudo docker run -d --restart=always -p 8000:8000 opensecurity/mobile-security-framework-mobsf:latest
