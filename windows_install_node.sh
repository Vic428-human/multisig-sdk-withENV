#!/bin/bash

# 使用 PowerShell 下載 NVM 安裝程序
echo "正在下載 NVM 安裝程序..."
powershell.exe -Command "Invoke-WebRequest -Uri https://github.com/coreybutler/nvm-windows/releases/download/1.1.12/nvm-setup.exe -OutFile nvm-setup.exe"

# 安裝 NVM
echo "正在安裝 NVM..."
powershell.exe -Command "Start-Process nvm-setup.exe -ArgumentList '/S' -NoNewWindow -Wait"

# 刪除安裝程序
echo "刪除安裝程序..."
rm nvm-setup.exe

# 安裝最新的 LTS 版本
echo "正在安裝20.18.0 版本的 Node.js..."
nvm install 20.18.0
nvm use 20.18.0

# 檢查 Node.js 和 npm 是否安裝成功
node_version=$(node -v)
npm_version=$(npm -v)

echo "Node.js version: $node_version"
echo "npm version: $npm_version"

echo "Node.js 和 npm 安裝完成！"

npm install
npm run build