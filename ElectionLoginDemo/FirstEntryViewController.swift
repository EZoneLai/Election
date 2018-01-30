//
//  FirstEntryViewController.swift
//  ElectionLoginDemo
//
//  Created by EZoneLai on 2017/2/15.
//  Copyright © 2017年 EZoneLai. All rights reserved.
//

import UIKit

class FirstEntryViewController: myViewController {

    // MARK: - 宣告基礎變數常數
    
    @IBOutlet weak var choseOccupationButtonTitle: UIButton!
    @IBOutlet weak var choseAreaButtonTitle: UIButton!
    
    //var adView:AdViewController!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.appdelegate.markController = self
        /*
        adView = AdViewController(nibName: "AdView", bundle: nil)
        
        self.present(adView, animated: true, completion:
            {
            /////
                
                for i in 1...5{
                    print("count\(i)seconds")
                    sleep(1)
                }
        self.dismiss(animated: true, completion: nil)
                
            }
        
        )*/
        
        //MARK:- 彈出視窗，告訴使用者讓使用者知道 為何需要這些資訊。
        //做一個alert或pop蹦現視窗
        var popWinController:UIAlertController;
        //呼叫UIAlertController的一個建構子來製作物件(title『標題文字』: "警告",message『訊息文字』: "你輸入了一個限制字元",preferredStyle『迸現風格（他是一種preferredStyle列舉，此先使用alert風格）』: UIAlertControllerStyle.alert);
        if appdelegate.device_token != ""{
           popWinController = UIAlertController(title: "貼心提醒",
                                                message: "請您輸入以下相關訊息\n讓議員能夠認識您",
                                                preferredStyle: UIAlertControllerStyle.actionSheet);
        }else{
           popWinController = UIAlertController(title: "重要訊息！",
                                                 message: "您必須允許推播通知\n請於設定->通知，開啟功能",
                                                 preferredStyle: UIAlertControllerStyle.actionSheet);
        }
        
        //準備迸現視窗的按鈕，使他有退出鈕
        var okButton:UIAlertAction
        okButton = UIAlertAction(title: "OK",
                                 style: UIAlertActionStyle.default,
                                 handler: nil);
        //加上按鈕入popWinController
        popWinController.addAction(okButton);
        //此時我們需要將畫面呈現在ViewController，但本calss只是一個Delegate，我們必須呼叫ViewController，故到上面去宣告一個ViewController來提供本calss轉換頁面呈現繃現視窗
        //popWinController.view.backgroundColor = UIColor(colorLiteralRed: 0.0, green: 0.6, blue: 0.3, alpha: 0.4)
        self.present(popWinController, animated: true, completion: nil);
        
        
        /////////
        //MARK: - 調整頁面下推
        //self.definesPresentationContext = true
        self.edgesForExtendedLayout = [];
        //self.navigationController?.isNavigationBarHidden = true
        
        //self.navigationItem.titleView?.isHidden = true;
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        
        if self.appdelegate.occupation == ""{
            self.choseOccupationButtonTitle.setTitle("選擇行業", for: .normal)
        }else{
            self.choseOccupationButtonTitle.setTitle(self.appdelegate.occupation, for: .normal)
        }
        if self.appdelegate.address == ""{
            self.choseAreaButtonTitle.setTitle("選擇地區", for: .normal)
        }else{
            self.choseAreaButtonTitle.setTitle(self.appdelegate.address, for: .normal)
        }
        // MARK: - 套用myController的返回鍵設定
        //自訂的標題
        self.setTitleAndBackTitle(title: "＝TWINS 鐵 票", backTitle: "", barColor: "clearColor")
        let titleView = UIImageView(frame: CGRect(x:0, y:0, width: 160, height: 40))
        titleView.contentMode = .scaleAspectFit
        titleView.image = self.appdelegate.logoImage
        self.navigationItem.titleView = titleView
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        // MARK: - 套用myController的返回鍵設定
        //自訂的標題
        self.setTitleAndBackTitle(title: "", backTitle: "", barColor: "entryColor")

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //取得裝置的類型來設計auto layer
    override func viewDidLayoutSubviews() {
        if appdelegate?.device_type == "iPhone" {
            //print("this is iPhone")
            //可以用這個來把東西都控制在想要的位置
            
        }else if (appdelegate?.device_type == "iPad"){
            //print("this is iPad")
            //可以用這個來把東西都控制在想要的位置
        }
    }
    
    @IBAction func qrCodeButton(_ sender: UIButton) {
        if appdelegate.device_token != ""{
            performSegue(withIdentifier: "QRReaderView", sender: nil)
        }else{
            //做一個alert或pop蹦現視窗
            var popWinController:UIAlertController;
            
            popWinController = UIAlertController(title: "注意",
                                                 message: "您必須允許推播通知\n請於設定->通知，開啟功能",
                                                 preferredStyle: UIAlertControllerStyle.alert);
            //準備迸現視窗的按鈕，使他有退出鈕
            var okButton:UIAlertAction
            okButton = UIAlertAction(title: "OK",
                                     style: UIAlertActionStyle.default,
                                     handler: nil);
            //加上按鈕入popWinController
            popWinController.addAction(okButton);
            self.present(popWinController, animated: true, completion: nil);
        }
        
        
    }
    
    @IBAction func choseOccupationButton(_ sender: UIButton) {
        
        performSegue(withIdentifier: "choseOccupationButton", sender: nil)
    }
    @IBAction func choseAreaButton(_ sender: UIButton) {
        
        performSegue(withIdentifier: "choseAreaButton", sender: nil)
    }
    
    @IBAction func toSignInButton(_ sender: UIButton) {
        
        if appdelegate.village      != "" &&
           appdelegate.occupation   != ""   {
            
            performSegue(withIdentifier: "toSignIn", sender: nil)
            
        }else{
            //TODO: 在此給一個彈出視窗，告知使用者該輸入的資料不完整。
            //做一個alert或pop蹦現視窗
            var popWinController:UIAlertController;
            
            
            
            if appdelegate.device_token != ""{
               popWinController = UIAlertController(title: "注意",
                                                    message: "請選擇行業或地區\n來進行下一步",
                                                    preferredStyle: UIAlertControllerStyle.alert);
            }else{
               popWinController = UIAlertController(title: "注意",
                                                    message: "您必須允許推播通知\n請於設定->通知，開啟功能",
                                                    preferredStyle: UIAlertControllerStyle.alert);
            }
            
            
            //準備迸現視窗的按鈕，使他有退出鈕
            var okButton:UIAlertAction
            okButton = UIAlertAction(title: "OK",
                                     style: UIAlertActionStyle.default,
                                     handler: nil);
            //加上按鈕入popWinController
            popWinController.addAction(okButton);
            
            //popWinController.view.backgroundColor = UIColor(red: 0.8, green: 0.0, blue: 0.0, alpha: 0.4)
            self.present(popWinController, animated: true, completion: nil);
            //print("請選擇行業或地區")
        }
        
        
    }
    
    @IBAction func returnButton(_ sender: UIButton) {
        if appdelegate.device_token != ""{
            performSegue(withIdentifier: "returnLogin", sender: nil)
        }else{
            //做一個alert或pop蹦現視窗
            var popWinController:UIAlertController;
            
            popWinController = UIAlertController(title: "注意",
                                                 message: "您必須允許推播通知\n請於設定->通知，開啟功能",
                                                 preferredStyle: UIAlertControllerStyle.alert);
            //準備迸現視窗的按鈕，使他有退出鈕
            var okButton:UIAlertAction
            okButton = UIAlertAction(title: "OK",
                                     style: UIAlertActionStyle.default,
                                     handler: nil);
            //加上按鈕入popWinController
            popWinController.addAction(okButton);
            self.present(popWinController, animated: true, completion: nil);
        }
        
        
        
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

