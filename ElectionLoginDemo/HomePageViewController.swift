//
//  HomePageViewController.swift
//  ElectionLoginDemo
//
//  Created by EZoneLai Lai on 2017/4/11.
//  Copyright © 2017年 EZoneLai. All rights reserved.
//

import UIKit

class HomePageViewController: myViewController, UIWebViewDelegate {

    @IBOutlet weak var myHomePageWebView: UIWebView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myHomePageWebView.delegate = self
        
        self.myHomePageWebView.loadRequest(
            URLRequest(url:
                //URL(string: "http://59.102.182.172/?check=daronaro")!
                //URL(string: "http://www.yahoo.com.tw")!
                URL(string: self.appdelegate.generic.myHomepageWeb)!,
                cachePolicy: .reloadIgnoringCacheData,
                timeoutInterval: 60
            )
        )
        print("我正在秀公司首頁myHomepageWeb\(self.appdelegate.generic.myHomepageWeb)")
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        // MARK: - 套用myController的返回鍵設定
        //自訂的標題
        self.setTitleAndBackTitle(title: "聯絡我們", backTitle: "ㄑ回主頁", barColor: "entryColor")
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
