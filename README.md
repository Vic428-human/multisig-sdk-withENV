## ios 調用 js 的 func 命名範例

- `param01`: 可以代多個字串型別的參數
- `calledFromIOS`: 手機跟網頁段共同定義的 func 名稱

用途：
將手機端的字就傳給網頁端，網頁端會根據手機端來的參數，跟 SAFE SDK 進行交互。

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
