#!/bin/bash

# 檢查是否安裝 Homebrew
if ! brew -v &> /dev/null
then
    echo "Homebrew 未安裝。請先安裝 Homebrew。"
    exit 1
fi

# 使用 Homebrew 安裝 Node.js
brew install node

# 檢查 Node.js 和 npm 是否安裝成功
node_version=$(node -v)
npm_version=$(npm -v)

echo "Node.js version: $node_version"
echo "npm version: $npm_version"

echo "Node.js 和 npm 安裝完成！"

npm install

npm run build