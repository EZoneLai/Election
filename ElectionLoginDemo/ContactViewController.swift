//
//  ContactViewController.swift
//  ElectionLoginDemo
//
//  Created by EZoneLai Lai on 2017/6/27.
//  Copyright © 2017年 EZoneLai. All rights reserved.
//

import UIKit

class ContactViewController: myViewController, UIWebViewDelegate{
    
    
    @IBOutlet weak var ContactView: UIWebView!
    
    
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.ContactView.delegate = self
        self.ContactView.loadRequest(
            URLRequest(url:
                URL(string: self.appdelegate.generic.contactWeb)!,
                       cachePolicy: .reloadIgnoringCacheData,
                       timeoutInterval: 60)
        )
        print("我正在秀contactWeb網頁\(self.appdelegate.generic.contactWeb)")
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // MARK: - 套用myController的返回鍵設定
        //自訂的標題
        self.setTitleAndBackTitle(title: "電話簿", backTitle: "ㄑ回主頁", barColor: "mainColor")
        let titleView = UIImageView(frame: CGRect(x:0, y:0, width: 160, height: 40))
        titleView.contentMode = .scaleAspectFit
        titleView.image = self.appdelegate.logoImage
        self.navigationItem.titleView = titleView
        indicatorView.stopAnimating()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        indicatorView.startAnimating()
        print("start loading")
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        indicatorView.stopAnimating()
        print("end loading")
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
