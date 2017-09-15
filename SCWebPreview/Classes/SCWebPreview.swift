//
//  SCWebPreview.swift
//  SCWebPreview
//
//  Created by myoungsc on 2017. 8. 22..
//  Copyright © 2017년 myoungsc. All rights reserved.
//

import UIKit

@IBDesignable public class SCWebPreview: NSObject {
    
    var webPages: [String] = []
    var previewDatas: [Int: [String: String]] = [:]
    
    //initializer webPages
    public func initWebPages(_ arr: [String]) {
        webPages = arr
    }
    
    //MARK: ## public Function ##
    //start crawling for Web Preview
    public func startCrawling(completionHandler: @escaping () -> Void) {
        print("start crawling")
        for (index, content) in self.webPages.enumerated() {
            DispatchQueue.global().async {
                self.urlFromCheck(content, completionHandler: { webPage in
                    guard let url = URL(string: webPage) else {
                        print("error: url is option value")
                        return
                    }
                    let session = URLSession.shared
                    let task = session.dataTask(with: url, completionHandler: { (data, response, error) in
                        if error == nil {
                            let dic: [String: String] = self.htmlParser(data!, strUrl: content)
                            self.previewDatas[index] = dic
                            
                            if self.previewDatas.count == self.webPages.count {
                                DispatchQueue.main.async {
                                    print("finish crawling")
                                    completionHandler()
                                }
                            }
                        } else {
                            print(error?.localizedDescription as Any)
                        }
                    })
                    task.resume()
                })
            }
        }
    }
    
    //return preview data
    public func getPreviewDataFromIndex(_ index: Int) -> [String: String] {
        guard previewDatas.count > index else {
            print("error: receive index exceeded the limit")
            return [:]
        }
        return previewDatas[index]!
    }
    
    //method - open safari
    public func openSafariFromUrl(_ index: Int) {
        let dic = getPreviewDataFromIndex(index)
        
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
    }
    
    //MARK: ## private Function ##
    //arrangement og: data in html
    private func htmlParser(_ data: Data, strUrl: String) -> [String: String] {
        
        var dic: [String: String] = [:]
        
        let urlContent = String(data: data, encoding: String.Encoding.utf8)
        let htmlTag = urlContent?.replacingOccurrences(of: "\n", with: "")
        
        let arr = htmlTag?.components(separatedBy: "<meta")
        
        func arrangement() {
            for i in 1 ..< (arr?.count)! {
                guard let content: String = arr?[i] else {
                    return
                }
                if content.contains("og:title") || content.contains("og:url")
                    || content.contains("og:description") || content.contains("og:image") {
                    
                    let arrContents = content.components(separatedBy: "\"")
                    
                    var key: String = "", content: String = ""
                    for (index, value) in arrContents.enumerated() {
                        if value.contains("property=") {
                            let tempKey = arrContents[index+1]
                            key = tempKey.trimmingCharacters(in: .whitespaces)
                        } else if value.contains("content=") {
                            content = arrContents[index+1]
                        }
                    }
                    dic[key] = content
                }
            }
        }        
        arrangement()
        
        guard let _: String = dic["og:url"] else {
            dic["og:url"] = strUrl
            return dic
        }
        return dic
    }
    
    //url from check and edit
    private func urlFromCheck(_ strUrl: String, completionHandler: @escaping (_ result: String) -> Void) {
        var webPage = strUrl
        
        guard webPage.hasPrefix("https") || webPage.hasPrefix("http") else {
            webPage = "https://" + webPage
            completionHandler(webPage)
            return
        }
        completionHandler(webPage)
    }    
}
