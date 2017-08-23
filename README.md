# SCWebPreview
[![CI Status](http://img.shields.io/travis/myoungsc/SCWebPreview.svg?style=flat)](https://travis-ci.org/myoungsc/SCWebPreview)
[![Version](https://img.shields.io/cocoapods/v/SCWebPreview.svg?style=flat)](http://cocoapods.org/pods/SCWebPreview)
[![License](https://img.shields.io/cocoapods/l/SCWebPreview.svg?style=flat)](http://cocoapods.org/pods/SCWebPreview)
[![Platform](https://img.shields.io/cocoapods/p/SCWebPreview.svg?style=flat)](http://cocoapods.org/pods/SCWebPreview)


## Description
A library that get metadata(url, image, title, description) for previewing via Web in HTML.

library support is only https://

How to use (http://)

Add "App Transport Security Setting-Allow Arbitrary Loads-YES" in polist file

## ScreenShot

## Requirements
```
* Swift 3.0.1
* XCode 8.3.3
* iOS 9.0 (Min SDK)
```

## Installation
SCWebPreview is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```swift
pod "SCWebPreview"

//After
pod install
```

## How To Use
- Get metadata from web in HTML

```swift
let webPages: [String] = ["https://github.com/myoungsc"]

let scWebPreview: SCWebPreview = SCWebPreview()
scWebPreview.initWebPages(webPages)
scWebPreview.startCrawling(){
    let dic = self.scWebPreview.getPreviewDataFromIndex(0)
    guard dic.count != 0 else {
        print("error: dic is optionl Value")
        return
    }
    self.dataBindingWebPagePreview(dic)
}
```

- example: url open safari

```Swift
let dic = scWebPreview.getPreviewDataFromIndex(0)
    guard let strUrl: String = dic["og:url"] else {
    print("error: og:url is optionl Value")
    return
}

if let url = URL(string: strUrl) {
    if #available(iOS 10.0, *) {
    UIApplication.shared.open(url, options: [:], completionHandler: { (result) in })
    } else {
    UIApplication.shared.openURL(url)
    }
}
```

## Author
myoung

[HomePage](http://devsc.tistory.com)

<myoungsc.dev@gmail.com>


## License
SCWebPreview is available under the MIT license. See the LICENSE file for more info.
