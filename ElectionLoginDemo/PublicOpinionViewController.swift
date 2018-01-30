//
//  PublicOpinionViewController.swift
//  ElectionLoginDemo
//
//  Created by EZoneLai Lai on 2017/4/3.
//  Copyright © 2017年 EZoneLai. All rights reserved.
//

import UIKit

class PublicOpinionViewController: myViewController, UIWebViewDelegate  {
    
    
    @IBOutlet weak var publicOpinionWebView: UIWebView!
    
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!

    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        self.publicOpinionWebView.delegate = self
        
        self.publicOpinionWebView.loadRequest(
            URLRequest(url:
                URL(string: self.appdelegate.generic.publicOpinionWeb)!,
                //URL(string: "http://www.yahoo.com.tw")!
                cachePolicy: .reloadIgnoringCacheData,
                timeoutInterval: 60
            )
        )
        print("我正在秀publicOpinionWeb網頁\(self.appdelegate.generic.publicOpinionWeb)")
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        // MARK: - 套用myController的返回鍵設定
        //自訂的標題
        //self.setMyTabBarTitleAndBackTitle(title: "緊急事件", backTitle: "ㄑ回主頁")
        self.setTitleAndBackTitle(title: "留言板", backTitle: "ㄑ回主頁", barColor: "mainColor")
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
