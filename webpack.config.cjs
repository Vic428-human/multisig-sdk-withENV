const path = require("path");
const webpack = require("webpack");
require("dotenv").config({ path: "./.env" });

module.exports = {
  entry: "./src/index.js", // 入口文件
  output: {
    filename: "bundle.js", // 輸出文件名
    path: path.resolve(__dirname, "dist"), // 輸出目錄
  },
  mode: "development", // 開發模式
  plugins: [
    new webpack.DefinePlugin({
      "process.env": JSON.stringify(process.env), // 定義 process.env 為空對象
    }),
  ],
};