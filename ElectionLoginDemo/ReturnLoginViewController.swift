//
//  ReturnLoginViewController.swift
//  ElectionLoginDemo
//
//  Created by EZoneLai on 2017/3/3.
//  Copyright © 2017年 EZoneLai. All rights reserved.
//

import UIKit

class ReturnLoginViewController: myViewController, Reaction {
    
    
    @IBOutlet weak var accountField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    var accountVaule:String!
    var passwordValue:String!
    var startNav:UINavigationController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        accountField.text = accountVaule
        passwordField.text = passwordValue
        
        
        var popWinController:UIAlertController;
        
        popWinController = UIAlertController(title: "歡迎回來",
                                             message: "請確認帳號密碼",
                                             preferredStyle: UIAlertControllerStyle.actionSheet);
        
        var okButton:UIAlertAction
        okButton = UIAlertAction(title: "OK",
                                 style: UIAlertActionStyle.default,
                                 handler: nil);
        
        popWinController.addAction(okButton);
        
        self.present(popWinController, animated: true, completion: nil);
        hideKeyboardWhenTappedAround()
        
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        startNav = self.navigationController
        // MARK: - 套用myController的返回鍵設定
        //自訂的標題
        self.setTitleAndBackTitle(title: "已有帳號", backTitle: "ㄑ上一頁", barColor: "entryColor")
        let titleView = UIImageView(frame: CGRect(x:0, y:0, width: 160, height: 40))
        titleView.contentMode = .scaleAspectFit
        titleView.image = self.appdelegate.logoImage
        self.navigationItem.titleView = titleView

    }
    override func viewWillDisappear(_ animated: Bool) {
        //在畫面消失之後把indicatorView關掉
        self.indicatorView.stopAnimating();
        //print("indicatorView STOP")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: - 登入按鈕
    //這裡包含了所有的判斷
    @IBAction func toMainViewButton(_ sender: UIButton) {
        self.indicatorView.startAnimating();
        //判斷使用者輸入的帳密
        if accountField.text  != "" &&
           passwordField.text != ""
        {
            //TODO： 將得到的帳密上傳去server確認
            //用post 傳資料
            DispatchQueue.main.async {
                
                let key_data:[String] = [
                    "account",
                    "password",
                    "device_token",
                    "device_type"
                ]
                
                let val_data:[String] = [
                    "\(self.accountField.text!.lowercased())",
                    "\(self.passwordField.text!.lowercased())",
                    "\(self.appdelegate.device_token)",
                    "\(self.appdelegate.device_type)"
                ]

                //TODO: 以後要做加密
                //測試
                let server_url_string = "http://\(self.appdelegate.server_ip)/check_device_token.php" //+ query_string
                print("上傳到mySQL\(server_url_string)")
                let cloud:my_cloud = my_cloud(server_url: server_url_string, type: TYPE.TEXT)
                cloud.delegator = self
                cloud.post_excute_data2(variable_name: key_data, datas: val_data)
                
            }
            
        }else{
            //把indicatorView關掉
            self.indicatorView.stopAnimating()
            
            var popWinController:UIAlertController;
            
            popWinController = UIAlertController(title: "注意",
                                                 message: "輸入帳號密碼，\n是為了保護您的個人資料",
                                                 preferredStyle: UIAlertControllerStyle.alert);
            
            var okButton:UIAlertAction
            okButton = UIAlertAction(title: "OK",
                                     style: UIAlertActionStyle.default,
                                     handler: nil);
            
            popWinController.addAction(okButton);
            
            self.present(popWinController, animated: true, completion: nil);
            
            //print("帳號或密碼要記得填哦！")
        }
        
        
    }
    
    
    //做一個私用的資料確認函數，因為預設是空的字串，要判斷沒有輸入
    func check_empty(input:String?)->Bool{
        var reslut = false
        if input != ""{
            reslut = true
        }
        return reslut
    }
    /*
     func createFile(atPath path: String, contents data: Data?, attributes attr: [String : Any]? = nil) -> Bool{
     
     }
     */
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    ////////////
    //my_cloud的各種函數
    
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
    func notifyExcuteResult(result:String){
        
        print("SERVER reply \(result)")
        let result = result.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        self.indicatorView.stopAnimating()
        
        let datas = result.components(separatedBy: "::")
        
        if (datas[0] == "update_device_token"){
            let already_path:String = NSHomeDirectory() + "/Documents/already.data"
            //取回guid值,存帳號密碼
            self.appdelegate.account = self.accountField.text!.lowercased();
            self.appdelegate.password = self.passwordField.text!.lowercased();
            self.appdelegate.guid = datas[1]
            var write_data = ""
            write_data = write_data + "safed_account:" + (self.accountField.text)!.lowercased() + "\n"
            write_data = write_data + "safed_password:" + (self.passwordField.text)!.lowercased() + "\n"
            write_data = write_data + "safed_guid:" + self.appdelegate.guid + "\n"
            write_data = write_data + "safed_device_token:" + self.appdelegate.device_token
            print("我有寫already.data")
            print("這是驗證檔案的路徑:\(already_path)")
            print("這是GUID :\(self.appdelegate.guid)")
            //print(NSHomeDirectory())
            //寫入資料
            do {
                try write_data.write(toFile: already_path, atomically: false, encoding: .utf8)
            } catch  {
                
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
                
                print("寫入失敗")
            }
            //MARK:- 確認身分後使使用者回到首頁
            //走初始登入流程，輸入所有的資料
            let firstEntryView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SelectSupportedViewController") as! SelectSupportedViewController
            startNav.pushViewController(firstEntryView, animated: true)
            //TODO: 暫時指定該使用者身分是A
            self.appdelegate.user_type = "A"
            print("這是device_token改變的登入")
            
        }else if (datas[0] == "right_return_login"){
            //MARK:- 確認身分後使使用者回到首頁
            let already_path:String = NSHomeDirectory() + "/Documents/already.data"
            //取回guid值,存帳號密碼
            self.appdelegate.account = self.accountField.text!.lowercased();
            self.appdelegate.password = self.passwordField.text!.lowercased();
            self.appdelegate.guid = datas[1]
            print("\(datas[1])")
            var write_data = ""
            write_data = write_data + "safed_account:" + (self.accountField.text)!.lowercased() + "\n"
            write_data = write_data + "safed_password:" + (self.passwordField.text)!.lowercased() + "\n"
            write_data = write_data + "safed_guid:" + self.appdelegate.guid + "\n"
            write_data = write_data + "safed_device_token:" + self.appdelegate.device_token
            print("我有寫already.data")
            print("這是驗證檔案的路徑:\(already_path)")
            print("這是GUID :\(self.appdelegate.guid)")
            //print(NSHomeDirectory())
            //寫入資料
            do {
                try write_data.write(toFile: already_path, atomically: false, encoding: .utf8)
            } catch  {
                
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
                
                print("寫入失敗")
            }
            //TODO: 載入登入後的主畫面，此處不能用之前的nav 必須是新的
            //MARK:- 確認身分後使使用者回到首頁
            let firstEntryView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SelectSupportedViewController") as! SelectSupportedViewController
            startNav.pushViewController(firstEntryView, animated: true)
            //TODO: 暫時指定該使用者身分是A
            self.appdelegate.user_type = "A"
            print("這是device_token沒改變的登入")
            //幫使用者登入Discuz
            //let uc_results:String
            //執行上網動作
            //uc_results = try String(contentsOf: URL(string: uc_url_string)!)
            //print(uc_results)
        }else{
            //print(result)
            
            var popWinController:UIAlertController;
            
            popWinController = UIAlertController(title: "注意！",
                                                 message: "未能成功登入\n帳號密碼有誤！",
                                                 preferredStyle: UIAlertControllerStyle.alert);
            //準備迸現視窗的按鈕，使他有退出鈕，按OK之後彈回根目錄
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
