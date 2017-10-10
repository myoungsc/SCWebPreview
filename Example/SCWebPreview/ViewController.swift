//
//  ViewController.swift
//  SCWebPreview
//
//  Created by myoungsc on 08/22/2017.
//  Copyright (c) 2017 myoungsc. All rights reserved.
//

import UIKit
import SCWebPreview

class ViewController: UIViewController {

    let scWebPreview: SCWebPreview = SCWebPreview()
    
    @IBOutlet weak var viewBack: UIView!
    @IBOutlet weak var ivWebImg: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbWebDescription: UILabel!
    
    @IBOutlet weak var viewBack2: UIView!
    @IBOutlet weak var ivWebImg2: UIImageView!
    @IBOutlet weak var lbTitle2: UILabel!
    @IBOutlet weak var lbWebDescription2: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initMain()
        
        let webPages: [String] = ["https://github.com/myoungsc", "http://devsc.tistory.com/"]
        scWebPreview.initWebPages(webPages)
        scWebPreview.startCrawling(){
            for i in 0 ..< webPages.count {
                let dic = self.scWebPreview.getPreviewDataFromIndex(i)
                guard dic.count != 0 else {
                    print("error: dic is optionl Value")
                    return
                }
                self.dataBindingWebPagePreview(dic, index: i)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }    
    
    func dataBindingWebPagePreview(_ dic: [String: String], index: Int) {
        
        let lbTitleTag = view.viewWithTag(10+index) as! UILabel
        let lbWebDescriptionTag = view.viewWithTag(20+index) as! UILabel
        let ivWebImgTag = view.viewWithTag(30+index) as! UIImageView
        
        lbTitleTag.text = dic["og:title"]
        lbWebDescriptionTag.text = dic["og:description"]?.trimmingCharacters(in: .whitespaces)
        
        let url = URL(string: dic["og:image"]!)
        do {
            let data = try Data(contentsOf: url!)
            let image = UIImage(data: data)
            ivWebImgTag.image = image
        } catch {
            ivWebImgTag.image = UIImage(named: "image_not_found")
        }
    }
   
    @IBAction func btnPreviewB(_ sender: UIButton) {
        scWebPreview.openSafariFromUrl(0)
    }
    
    @IBAction func btnPreview2B(_ sender: UIButton) {
        scWebPreview.openSafariFromUrl(1)
    }    
    
    func initMain() {
        
        viewBack.layer.borderWidth = 0.5
        viewBack.layer.borderColor = UIColor.lightGray.cgColor
        
        ivWebImg.layer.cornerRadius = 4.0
        ivWebImg.layer.masksToBounds = true
        
        viewBack2.layer.borderWidth = 0.5
        viewBack2.layer.borderColor = UIColor.lightGray.cgColor
        
        ivWebImg2.layer.cornerRadius = 4.0
        ivWebImg2.layer.masksToBounds = true
        
    }
    
}
