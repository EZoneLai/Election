//
//  PushNoticeViewController.swift
//  ElectionLoginDemo
//
//  Created by EZoneLai Lai on 2017/5/10.
//  Copyright © 2017年 EZoneLai. All rights reserved.
//

import UIKit

class PushNoticeViewController: myViewController, UIWebViewDelegate{
    
    
    @IBOutlet weak var PushNoticeWebView: UIWebView!
    
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.PushNoticeWebView.delegate = self
        
        self.PushNoticeWebView.loadRequest(
            URLRequest(url:
                URL(string: self.appdelegate.generic.pushNoticeWeb)!,
                //URL(string: "http://www.yahoo.com.tw")!
                //URL(string: "http://twin.taipei/discuz/upload")!
                cachePolicy: .reloadIgnoringCacheData,
                timeoutInterval: 60
            )
        )
        print("我正在秀pushNoticWeb網頁，推播服務\(self.appdelegate.generic.pushNoticeWeb)")
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // MARK: - 套用myController的返回鍵設定
        //自訂的標題
        self.setMyTabBarTitleAndBackTitle(title: "工具箱", backTitle: "ㄑ回主頁", barColor: "mainColor")
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
