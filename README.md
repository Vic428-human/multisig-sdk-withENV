[不用計算 nonce 的自動上鏈的項目地址](https://github.com/Vic428-human/multi-sig)
用到情境：當你不知道此項目的 nonce 時，你想知道當前合約地址所處在的實際 nonce 數時

## Table of contents

- [IOS to JS](#ios-to-js)
- [Guides](#guides)
- [JS to IOS](#js-to-ios)

## IOS to JS

- `param01`: 可以代多個字串型別的參數
- `calledFromIOS`: 手機跟網頁段共同定義的 func 名稱

用途：
ios 調用 js 的 func 命名範例
將手機端的字就傳給網頁端，網頁端會根據手機端來的參數，跟 SAFE SDK 進行交互。

IOS 代碼：

```swift
@IBAction func jsbtn(_ sender: Any) {
        let jsFunction = "calledFromIOS(\"param01\", \"param02\", \"param03\")"
        print("jsFunction value: \(jsFunction)")
        webView.evaluateJavaScript(jsFunction) { (result, error) in
            if let error = error {
                print("Error calling JavaScript function: \(error)")
            } else if let result = result {
                print("Result from JavaScript function: \(result)")
            }
        }
    }
```

JS 代碼：

```js
const calledFromIOS = async (param01, param02, param03) => {
  try {
    console.log("param01===>", param01);
    return initGlobalSafe;
  } catch (error) {
    callApp(error, "error");
  }
};
```

## Guides

用途：
手機開發人員可以直接到 ./dist 路徑裡的 index.html 自行查看每個 func 定義的 params 參數用途

| FuncName                        | 行爲                                 |
| ------------------------------- | ------------------------------------ |
| calledInit                      | 發起人 進入手機介面當下就進行初始化  |
| calledCreateTransaction         | 發起創建交易時 同時 開始進行簽名投票 |
| calledSignTransactionFromMobile | 其餘簽署人開始簽名投票               |
| calledExecuteTransaction        | 發起人將交易上鏈                     |

## JS to IOS

用途：

橋樑識別符值 ex: jsToSwift
手機端拿到 SDK 回傳的字傳後，會回傳給手機端，透過事先定義的 橋樑識別符值

IOS 代碼：

```swift
    let config = WKWebViewConfiguration()
    let contentController = WKUserContentController()
    contentController.add(self, name: "jsToSwift")
    config.userContentController = contentController

    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == "jsToSwift" {
            if var messageBody = message.body as? String {
                print("從 JS 收到資料: \(messageBody)")
                // 在此處處理從 JavaScript 收到的資料
                messageBody = messageBody.replacingOccurrences(of: "\n", with: "\\n")

                textView.text = messageBody
            }
        }
    }
```

JS 代碼：

```js
const callApp = (string, type = "callMessage") => {
  new Map([
    [
      "IOS",
      () => {
        console.log(`====從網頁端傳資料給手機端=====`, string);
        // 橋樑識別符值 jsToSwift
        //window.webkit.messageHandlers.<橋樑識別符值>.postMessage
        window?.webkit.messageHandlers[type].postMessage(string);
      },
    ],
    [
      "Android",
      () => {
        JsAndroid[type](string);
      },
    ],
  ]).get(device)();
};

callApp("回傳給手機端的內容字串", "jsToSwift");
```
