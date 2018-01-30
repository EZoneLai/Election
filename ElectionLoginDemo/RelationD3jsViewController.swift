//
//  RelationD3jsViewController.swift
//  ElectionLoginDemo
//
//  Created by EZoneLai Lai on 2017/6/21.
//  Copyright © 2017年 EZoneLai. All rights reserved.
//

import UIKit

class RelationD3jsViewController: myViewController, UIWebViewDelegate, Reaction {
    
    
    
    
    @IBOutlet weak var RelationD3jsView: UIWebView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        // MARK: - 套用myController的返回鍵設定
        //自訂的標題
        self.setMyTabBarTitleAndBackTitle(title: "檢視器", backTitle: "ㄑ回主頁", barColor: "mainColor")
        //TODO: 我改到這，要改成my_cloud POST
        DispatchQueue.main.async {
            /*
            let key_data:[String] = [
                "account",
                "password"
            ]
            
            let val_data:[String] = [
                "\(self.appdelegate.account)",
                "\(self.appdelegate.password)"
            ]
            
            //TODO: 以後要做加密
            //測試
            let server_url_string = "http://\(self.appdelegate.server_ip)/trees/genD3jsview.php" //+ query_string
            print("上傳到mySQL\(server_url_string)")
            let cloud:my_cloud = my_cloud(server_url: server_url_string, type: TYPE.TEXT)
            cloud.delegator = self
            cloud.post_excute_data2(variable_name: key_data, datas: val_data)
            */
            
            var query_string = ""
            query_string = query_string + "account=\(self.appdelegate.account.lowercased())&"
            query_string = query_string + "password=\(self.appdelegate.password.lowercased())"
            
            query_string = query_string.addingPercentEncoding( withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
            //query_string = query_string.encodeUrl()
            
            //TODO: 以後要做加密
            
            //測試
            let server_url_string = "http://\(self.appdelegate.server_ip)/trees/genD3jsview.php?" + query_string
            //print(server_url_string)
            self.appdelegate.generic.relationD3jsWeb = server_url_string
            print(self.appdelegate.generic.relationD3jsWeb)
            //self.appdelegate.RelationD3jsView = server_url_string
            
        }
        
        indicatorView.stopAnimating()
    }
    override func viewDidAppear(_ animated: Bool) {
        self.RelationD3jsView.delegate = self
        self.RelationD3jsView.loadRequest(
            URLRequest(url:
                URL(
                    //string: self.appdelegate.RelationD3jsView
                    string: self.appdelegate.generic.relationD3jsWeb
                    )!,
                       cachePolicy: .reloadIgnoringCacheData,
                       timeoutInterval: 60
            )
        )
        print("我正在秀RelationD3jsView網頁\(self.appdelegate.generic.relationD3jsWeb)")
        //print("我正在秀RelationD3jsView網頁\(self.appdelegate.RelationD3jsView)")
        
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
    func notifyString(text: String) {
        
    }
    
    func notifyImage(image: UIImage) {
        
    }
    
    func notifyByte(data: Data) {
        
    }
    
    func progressReport(persent: Double) {
        
    }
    
    func notifyError(error: String) {
        print("ERROR is \(error)")
        self.indicatorView.stopAnimating()
        var popWinController:UIAlertController;
        
        popWinController = UIAlertController(title: "注意！",
                                             message: "未能成功登入\n網路連線有誤",
                                             preferredStyle: UIAlertControllerStyle.alert);
        
        var okButton:UIAlertAction
        okButton = UIAlertAction(title: "OK",
                                 style: UIAlertActionStyle.default,
                                 handler:{
                                    finish
                                    in
                                    self.navigationController?.popViewController(animated: true)
        }
            
        );
        
        popWinController.addAction(okButton);
        
        self.present(popWinController, animated: true, completion: nil);
        
        print("網路出現問題")
        print(error)
    }
    
    func notifyExcuteResult(result: String) {
        print("SERVER reply \(result)")
        let result = result.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        self.indicatorView.stopAnimating()
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
