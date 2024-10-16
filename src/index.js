import axios from "axios";
import SafeProtocalKit from "@safe-global/protocol-kit";
import { ethers } from "ethers";

// 將函數暴露給全域範圍
window.utils = {
  axios,
  SafeProtocalKit,
  ethers,
  env: process.env,
};