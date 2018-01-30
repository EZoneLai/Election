//
//  Emergency2ViewController.swift
//  ElectionLoginDemo
//
//  Created by EZoneLai Lai on 2017/9/19.
//  Copyright © 2017年 EZoneLai. All rights reserved.
//

import UIKit

class Emergency2ViewController: myViewController, UIWebViewDelegate {

    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    @IBOutlet weak var emergencyWebview: UIWebView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.emergencyWebview.delegate = self
        
        self.emergencyWebview.loadRequest(
            URLRequest(url:
                URL(string: self.appdelegate.generic.emergencyWeb)!,
                       cachePolicy: .reloadIgnoringCacheData,
                       timeoutInterval: 60
            )
        )
        print("我正在秀emergencyWeb網頁\(self.appdelegate.generic.emergencyWeb)")
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        // MARK: - 套用myController的返回鍵設定
        //自訂的標題
        self.setMyTabBarTitleAndBackTitle(title: "緊急事件", backTitle: "ㄑ回主頁", barColor: "mainColor")
        indicatorView.stopAnimating()
    }
    override func viewDidAppear(_ animated: Bool) {
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func webViewDidStartLoad(_ webView: UIWebView) {
        indicatorView.startAnimating();
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
