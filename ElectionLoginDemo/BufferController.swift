//
//  ViewController.swift
//  ElectionLoginDemo
//
//  Created by EZoneLai on 2017/2/8.
//  Copyright © 2017年 EZoneLai. All rights reserved.
//

import UIKit

class BufferController: myViewController, Reaction {
    
    @IBOutlet weak var bufferImage: UIImageView!
    
    var ticle:Timer!
    var timePeriod:TimeInterval = 0
    let already_path:String = NSHomeDirectory() + "/Documents/already.data"
    let default_head_path:String = NSHomeDirectory() + "/Documents/default.png"
    let manager:FileManager = FileManager.default
    var startNav:UINavigationController!
    
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        
        //廣告圖
        self.bufferImage.image = UIImage(named: "entryImage")
        //self.navigationController?.isNavigationBarHidden = true
        
        startNav = self.navigationController
        //檢查登入紀錄檔already.data，如果不存在
        if !manager.fileExists(atPath: already_path){
            //沒檔案的人都預設是user_type = ""
            appdelegate.user_type = ""
            ///走初始登入流程，輸入所有的資料
            let firstEntryView = UIStoryboard(name: "Entry", bundle: nil).instantiateViewController(withIdentifier: "FirstEntryView") as! FirstEntryViewController
            startNav.pushViewController(firstEntryView, animated: true)
            print("沒有檔案")
            
        }else{
            ///如果already.data存在，走已有帳號登入流程
            print("已有檔案")
            do {
                //抓出該檔案中的資料出來，我們只存帳號/密碼/guid/device_token
                //safed_account:xxxxxx
                //safed_password:xxxxx
                //let already_member_data = try String(contentsOf: URL(string: already_path)!, encoding: String.Encoding.utf8)
                let already_member_data  = try String(contentsOfFile: already_path)
                let lines                = already_member_data.components(separatedBy: "\n")
                let safed_account        = (lines[0] as String).components(separatedBy: ":")
                appdelegate.account      = safed_account[1]
                let safed_password       = (lines[1] as String).components(separatedBy: ":")
                appdelegate.password     = safed_password[1]
                let safed_guid           = (lines[2] as String).components(separatedBy: ":")
                appdelegate.guid         = safed_guid[1]
                let safed_device_token   = (lines[3] as String).components(separatedBy: ":")
                appdelegate.device_token = safed_device_token[1]
                print("拿回的guid\(safed_guid)")
                print("拿回的token\(safed_device_token)")
                print("我們的帳密是account=\(appdelegate.account)&password=\(appdelegate.password)")
                let key_data:[String] = [
                    "account",
                    "password",
                    "device_token",
                    "device_type"
                ]
                
                let val_data:[String] = [
                    "\(appdelegate.account)",
                    "\(appdelegate.password)",
                    "\(appdelegate.device_token)",
                    "\(appdelegate.device_type)"
                ]
                //上傳到Server Check從 sever 確定此帳密有效(login.php回傳true，來確定這是我們的會員)
                let user_check_url_string = "http://\(appdelegate.server_ip)/check_device_token.php"
                //let user_check_url = URL(string: "http://\(server_ip)/login.php")//?account=\(account)&password=\(password)")!
                let cloud:my_cloud = my_cloud(server_url: user_check_url_string, type: TYPE.TEXT)
                cloud.delegator = self
                cloud.post_excute_data2(variable_name: key_data, datas: val_data)
                print("\(user_check_url_string)")
                
            } catch  {
                //fail read
                var popWinController:UIAlertController;
                
                popWinController = UIAlertController(title: "注意！",
                                                     message: "程式內部錯誤\n現在退出程式\n請重啟程式",
                                                     preferredStyle: UIAlertControllerStyle.alert);
                
                var okButton:UIAlertAction
                okButton = UIAlertAction(title: "OK",
                                         style: UIAlertActionStyle.default,
                                         handler:{
                                            finish
                                            in
                                            OperationQueue.main.addOperation {
                                                exit(1)
                                            }
                }
                    
                );
                
                popWinController.addAction(okButton);
                self.present(popWinController, animated: true, completion: nil);
                print(error)
                print("無法開啟紀錄檔")
                
            }
         
            
            
        }
        
        
    }
    
    override func viewDidLayoutSubviews() {
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        if indicator != nil {
//            indicator.startAnimating()
//        }else{
//            print("indicator = nil")
//        }
        
        timePeriod = self.appdelegate.timePeriod

        self.ticle = Timer.scheduledTimer(
            timeInterval: timePeriod,
            target: self,
            selector: #selector(BufferController.go),
            userInfo: nil,
            repeats: false)
    }
    
    func go(){
        
        print("AD now")
        
        
        
        
        
        
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    ////////////////////
    //使用my_cloud的各個func
    
    func notifyString(text:String){
        
    }
    func notifyImage(image:UIImage){
        
    }
    func notifyByte(data:Data){
        
    }
    func progressReport(persent:Double){
        
    }
    func notifyError(error:String){
        print("ERROR is \(error)")
        
        var popWinController:UIAlertController;
        
        popWinController = UIAlertController(title: "注意！",
                                             message: "未能成功登入\n網路連線有誤\n現在退出程式\n請您檢查網路",
                                             preferredStyle: UIAlertControllerStyle.alert);
        
        var okButton:UIAlertAction
        okButton = UIAlertAction(title: "OK",
                                 style: UIAlertActionStyle.default,
                                 handler:{
                                    finish
                                    in
                                    OperationQueue.main.addOperation {
                                        exit(1)
                                    }
        }
            
        );
        
        popWinController.addAction(okButton);
        
        self.present(popWinController, animated: true, completion: nil);
        
        print("網路出現問題")
        print(error)
        
    }
    func notifyExcuteResult(result:String){
        print("SERVER reply \(result)")
        let result = result.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        //self.indicatorView.stopAnimating()
        let datas = result.components(separatedBy: "::")
        if (datas[0] == "update_device_token"){
            let already_path:String = NSHomeDirectory() + "/Documents/already.data"
            //TODO: 刪除already.data
            do{
                try manager.removeItem(atPath: already_path)
            }catch{
                //fail delete
                var popWinController:UIAlertController;
                
                popWinController = UIAlertController(title: "注意！",
                                                     message: "程式內部錯誤\n現在退出程式\n請重啟程式",
                                                     preferredStyle: UIAlertControllerStyle.alert);
                
                var okButton:UIAlertAction
                okButton = UIAlertAction(title: "OK",
                                         style: UIAlertActionStyle.default,
                                         handler:{
                                            finish
                                            in
                                            OperationQueue.main.addOperation {
                                                self.appdelegate.applicationWillTerminate(UIApplication.shared)
                                                exit(1)
                                            }
                }
                    
                );
                
                popWinController.addAction(okButton);
                
                self.present(popWinController, animated: true, completion: nil);
                
                print("刪除紀錄檔失敗")
                print(error)
                
                
               
            }
            //換頁回FirstEntryView
            ///走初始登入流程，輸入所有的資料
            let firstEntryView = UIStoryboard(name: "Entry", bundle: nil).instantiateViewController(withIdentifier: "FirstEntryView") as! FirstEntryViewController
            startNav.pushViewController(firstEntryView, animated: true)
            print("已經沒有檔案")
            //TODO: 暫時指定該使用者身分是""
            self.appdelegate.user_type = ""
            print("這是device_token改變的登入")
            
        }else if (datas[0] == "right_return_login"){
            //TODO: 載入登入後的主畫面，此處不能用之前的nav 必須是新的
            //MARK:- 確認身分後使使用者回到首頁
            let selectView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SelectSupportedViewController") as! SelectSupportedViewController
            startNav.pushViewController(selectView, animated: true)
            //TODO: 暫時指定該使用者身分是A
            self.appdelegate.user_type = "A"
            self.appdelegate.guid = datas[1]
            print("\(datas[1])")
            print("這是device_token沒改變的登入")
            var write_data = ""
            write_data = write_data + "safed_account:" + self.appdelegate.account + "\n"
            write_data = write_data + "safed_password:" + self.appdelegate.password  + "\n"
            write_data = write_data + "safed_guid:" + self.appdelegate.guid  + "\n"
            write_data = write_data + "safed_device_token:" + self.appdelegate.device_token
            print("這是驗證檔案的路徑:\(already_path)")
            print("我重寫already.data")
            print("這是GUID :\(self.appdelegate.guid)")
            //print(NSHomeDirectory())
            //寫入資料
            do {
                try write_data.write(toFile: already_path, atomically: false, encoding: .utf8)
                print("寫already.data成功")
                
            } catch  {
                //TODO: 做彈出視窗
                
                var popWinController:UIAlertController;
                
                popWinController = UIAlertController(title: "注意！",
                                                     message: "未能成功寫入\n下次請選擇『已有帳號』登入系統",
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
                
                print("寫入already.data失敗")
                
            }
        }else{
            //print(result)
            //MARK: 做可以彈回首頁的彈出視窗
            var popWinController:UIAlertController;
            
            popWinController = UIAlertController(title: "注意！",
                                                 message: "未能成功登入\n帳號密碼有誤！",
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
            
            print("簽入帳密有誤")
            
            return
        }
        
    }
}

