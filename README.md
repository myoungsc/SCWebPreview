# SCWebPreview
[![CI Status](http://img.shields.io/travis/myoungsc/SCWebPreview.svg?style=flat)](https://travis-ci.org/myoungsc/SCWebPreview)
[![Version](https://img.shields.io/cocoapods/v/SCWebPreview.svg?style=flat)](http://cocoapods.org/pods/SCWebPreview)
[![License](https://img.shields.io/cocoapods/l/SCWebPreview.svg?style=flat)](http://cocoapods.org/pods/SCWebPreview)
[![Platform](https://img.shields.io/cocoapods/p/SCWebPreview.svg?style=flat)](http://cocoapods.org/pods/SCWebPreview)


## Description
A library that get metadata(og:url, og:image, og:title, og:description) for previewing via Web in HTML.

How to use (http://)
Add "App Transport Security Setting-Allow Arbitrary Loads-YES" in polist file

## ScreenShot
![](https://github.com/myoungsc/SCWebPreview/blob/master/SCWebPreview_ScreenShot.gif?raw=true)

## Requirements
```swift
* Swift 4.2
* XCode 10.0
* iOS 9.0 (Min SDK)
```

## Installation
SCWebPreview is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```swift
//Add Podfile
pod "SCWebPreview" //Swift 4.2
pod "SCWebPreview", '~> 1.0.0' //Swift 4.0
pod "SCWebPreview", '~> 0.1.1' //Swift 3.0

//After
pod install
```

## How To Use
- Get metadata from web in HTML

```swift
import SCWebPreview

let webPages: [String] = ["https://github.com/myoungsc", "http://devsc.tistory.com/"]
let scWebPreview = SCWebPreview()
scWebPreview.initWebPages(webPages)
scWebPreview.startCrawling(){
    for i in 0 ..< webPages.count {
        let dic = self.scWebPreview.getPreviewDataFromIndex(i)
        guard dic.count != 0 else {
            print("error: dic is optionl Value")
            return
        }
        //doSomething
    }
}
```

- example: get date form index

```Swift
let dicWebData: [String: String] = scWebPreview.getPreviewDataFromIndex(0)

print("og:url - \(dicWebData["og:url"]!)")
print("og:url - \(dicWebData["og:title"]!)")
print("og:url - \(dicWebData["og:description"]!)")
print("og:url - \(dicWebData["og:image"]!)")
```

- example: url open safari

```Swift
scWebPreview.openSafariFromUrl(0)
```

## Author
myoung

[HomePage](http://devsc.tistory.com)

<myoungsc.dev@gmail.com>


## License
SCWebPreview is available under the MIT license. See the LICENSE file for more info.
