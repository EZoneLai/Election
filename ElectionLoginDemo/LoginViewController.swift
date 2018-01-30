//
//  LoginViewController.swift
//  ElectionLoginDemo
//
//  Created by EZoneLai on 2017/2/10.
//  Copyright © 2017年 EZoneLai. All rights reserved.
//

import UIKit

class LoginViewController: myViewController ,UITextFieldDelegate, Reaction{
    
    @IBOutlet weak var accountField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    var accountString:String = ""
    var passwordString:String = ""
    var guid:String = ""
    //MARK:- UITextFieldDelegate函數 
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.accountField.resignFirstResponder()
        self.passwordField.resignFirstResponder()
        return true
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.accountField.delegate = self
        self.passwordField.delegate = self
        //做一個alert或pop蹦現視窗
        var popWinController:UIAlertController;
        //呼叫UIAlertController的一個建構子來製作物件(title『標題文字』: "警告",message『訊息文字』: "你輸入了一個限制字元",preferredStyle『迸現風格（他是一種preferredStyle列舉，此先使用alert風格）』: UIAlertControllerStyle.alert);
        popWinController = UIAlertController(title: "貼心提醒",
                                             message: "輸入帳號密碼\n是為了保護您的個人資料",
                                             preferredStyle: UIAlertControllerStyle.actionSheet);
        //準備迸現視窗的按鈕，使他有退出鈕
        var okButton:UIAlertAction
        okButton = UIAlertAction(title: "OK",
                                 style: UIAlertActionStyle.default,
                                 handler: nil);
        //加上按鈕入popWinController
        popWinController.addAction(okButton);
        //此時我們需要將畫面呈現在ViewController，但本calss只是一個Delegate，我們必須呼叫ViewController，故到上面去宣告一個ViewController來提供本calss轉換頁面呈現繃現視窗
        self.present(popWinController, animated: true, completion: nil);
        hideKeyboardWhenTappedAround()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // MARK: - 套用myController的返回鍵設定
        //自訂的標題
        self.setTitleAndBackTitle(title: "設定帳號密碼", backTitle: "ㄑ上一頁", barColor: "entryColor")
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
        //把indicatorView打開
        self.indicatorView.startAnimating();
        accountString = accountField.text!.lowercased()
        passwordString = passwordField.text!.lowercased()
        
        //判斷使用者輸入的帳密
        if accountString  == "" ||
            passwordString == ""
        {
            //把indicatorView關掉
            self.indicatorView.stopAnimating();
            appdelegate.account = accountString
            appdelegate.password = passwordString
            print("此使用者的帳號：\(appdelegate.account)")
            print("此使用者的密碼：\(appdelegate.password)")
            //TODO: 在此給一個彈出視窗，告知使用者該輸入的資料不完整。
            //做一個alert或pop蹦現視窗
            var popWinController:UIAlertController;
            //呼叫UIAlertController的一個建構子來製作物件(title『標題文字』: "警告",message『訊息文字』: "你輸入了一個限制字元",preferredStyle『迸現風格（他是一種preferredStyle列舉，此先使用alert風格）』: UIAlertControllerStyle.alert);
            popWinController = UIAlertController(title: "注意!",
                                                 message: "輸入帳號密碼\n是為了確保您的個人資料",
                                                 preferredStyle: UIAlertControllerStyle.alert);
            //準備迸現視窗的按鈕，使他有退出鈕
            var okButton:UIAlertAction
            okButton = UIAlertAction(title: "OK",
                                     style: UIAlertActionStyle.default,
                                     handler: nil);
            //加上按鈕入popWinController
            popWinController.addAction(okButton);
            //此時我們需要將畫面呈現在ViewController，但本calss只是一個Delegate，我們必須呼叫ViewController，故到上面去宣告一個ViewController來提供本calss轉換頁面呈現繃現視窗
            self.present(popWinController, animated: true, completion: nil);
            
            //print("帳號或密碼要記得填哦！")
            return
        }
        
        //利用寫在外面的函數check_empty來判斷必須的值的Bool為是才進行下一步
        guard
            check_empty(input: appdelegate.device_token),
            check_empty(input: appdelegate.occupation),
            check_empty(input: appdelegate.address),
            check_empty(input: appdelegate.name),
            check_empty(input: appdelegate.telephone),
            check_empty(input: appdelegate.sex),
            check_empty(input: String(appdelegate.birth_year))
            
            else
        {
            //TODO: 在此做一個判斷，讓我們確定使用者該輸入的資料已完整。
            
            //print("不得為空")
            return
        }
        
        //print("存入資料庫")
        //用POST 傳資料
        DispatchQueue.main.async {
            //程式產生，guid
            self.guid        = NSUUID().uuidString
            self.appdelegate.guid = self.guid
            print("此使用者的guid：\(self.guid)")
            let key_data:[String] = [
            "occupation",
            "address",
            "account",
            "password",
            "name",
            "telephone",
            "sex",
            "birth_year",
            "guid",
            "uesr_type",
            "device_token",
            "upstream",
            "leader_id",
            "email",
            "campaign_type",
            "device_type"
            ]
            
            let val_data:[String] = [
                "\(self.appdelegate.occupation)",
                "\(self.appdelegate.address)",
                "\(self.accountString)",
                "\(self.passwordString)",
                "\(self.appdelegate.name)",
                "\(self.appdelegate.telephone)",
                "\(self.appdelegate.sex)",
                "\(self.appdelegate.birth_year)"+"",
                "\(self.appdelegate.guid)",
                "\(self.appdelegate.user_type)",
                "\(self.appdelegate.device_token)",
                "\(self.appdelegate.upstream)"+"",
                "\(self.appdelegate.leader_id)"+"",
                "\(self.appdelegate.email)",
                "\(self.appdelegate.campaign_type)",
                "\(self.appdelegate.device_type)"
            ]
            
            let server_url_string = "http://\(self.appdelegate.server_ip)/save.php" //+ query_string
            print("上傳到mySQL\(server_url_string)")
            let cloud:my_cloud = my_cloud(server_url: server_url_string, type: TYPE.TEXT)
            cloud.delegator = self
            cloud.post_excute_data2(variable_name: key_data, datas: val_data)
            
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
    ////////////////////
    
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
    }
    func notifyExcuteResult(result:String){
        
        print("SERVER reply \(result)")
        let result = result.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        self.indicatorView.stopAnimating()
        self.indicatorView.isHidden = true
        //self.indicatorView.hidesWhenStopped = true
        if (result == "successful"){
            //建立一個使用者登入紀錄檔，already.data
            print("成功將使用者加入資料庫")
            let already_path:String = NSHomeDirectory() + "/Documents/already.data"
            
            var write_data = ""
            write_data = write_data + "safed_account:" + self.accountString + "\n"
            write_data = write_data + "safed_password:" + self.passwordString  + "\n"
            write_data = write_data + "safed_guid:" + self.guid  + "\n"
            write_data = write_data + "safed_device_token:" + self.appdelegate.device_token
            print(self.guid)
            print("這是驗證檔案的路徑:\(already_path)")
            //print(NSHomeDirectory())
            //寫入資料
            do {
                try write_data.write(toFile: already_path, atomically: false, encoding: .utf8)
                print("成功將使用者寫入already.data")
            } catch  {
                
                //資料登入失敗，下次請選擇『已有帳號』登入系統
                var popWinController:UIAlertController;
                //呼叫UIAlertController的一個建構子來製作物件(title『標題文字』: "警告",message『訊息文字』: "你輸入了一個限制字元",preferredStyle『迸現風格（他是一種preferredStyle列舉，此先使用alert風格）』: UIAlertControllerStyle.alert);
                popWinController = UIAlertController(title: "注意！",
                                                     message: "未能成功寫入\n下次請選擇『已有帳號』登入系統",
                                                     preferredStyle: UIAlertControllerStyle.alert);
                //準備迸現視窗的按鈕，使他有退出鈕
                var okButton:UIAlertAction
                okButton = UIAlertAction(title: "OK",
                                         style: UIAlertActionStyle.default,
                                         handler: nil);
                //加上按鈕入popWinController
                popWinController.addAction(okButton);
                //此時我們需要將畫面呈現在ViewController，但本calss只是一個Delegate，我們必須呼叫ViewController，故到上面去宣告一個ViewController來提供本calss轉換頁面呈現繃現視窗
                self.present(popWinController, animated: true, completion: nil);
                //把indicatorView關掉
                self.indicatorView.stopAnimating();
                print("寫入already.data失敗")
            }
            //MARK:- 確認身分後使使用者回到首頁
            //載入登入後的主畫面，必須使用新的 nav
            var bundle:Bundle
            bundle = Bundle.main
            var storyboard:UIStoryboard
            storyboard = UIStoryboard(name: "Main", bundle: bundle)
            let controller:UIViewController
            controller = storyboard.instantiateViewController(withIdentifier: "SelectSupportedViewController") as! SelectSupportedViewController
            self.navigationController?.pushViewController(controller, animated: true)
            //TODO: 暫時指定該使用者身分是C
            self.appdelegate.user_type = "C"
            
            
        }else if(result == "account used"){
            //print(result)
            //TODO: 做彈出視窗
            var popWinController:UIAlertController;
            //呼叫UIAlertController的一個建構子來製作物件(title『標題文字』: "警告",message『訊息文字』: "你輸入了一個限制字元",preferredStyle『迸現風格（他是一種preferredStyle列舉，此先使用alert風格）』: UIAlertControllerStyle.alert);
            popWinController = UIAlertController(title: "注意！",
                                                 message: "未能成功登入\n帳號已被使用！",
                                                 preferredStyle: UIAlertControllerStyle.alert);
            //準備迸現視窗的按鈕，使他有退出鈕
            var okButton:UIAlertAction
            okButton = UIAlertAction(title: "OK",
                                     style: UIAlertActionStyle.default,
                                     handler: nil);
            //加上按鈕入popWinController
            popWinController.addAction(okButton);
            //此時我們需要將畫面呈現在ViewController，但本calss只是一個Delegate，我們必須呼叫ViewController，故到上面去宣告一個ViewController來提供本calss轉換頁面呈現繃現視窗
            self.present(popWinController, animated: true, completion: nil);
            
            print("帳號重複")
            //把indicatorView關掉
            self.indicatorView.stopAnimating();
            
        }else{
            print(result)
            //TODO: 做彈出視窗
            var popWinController:UIAlertController;
            //呼叫UIAlertController的一個建構子來製作物件(title『標題文字』: "警告",message『訊息文字』: "你輸入了一個限制字元",preferredStyle『迸現風格（他是一種preferredStyle列舉，此先使用alert風格）』: UIAlertControllerStyle.alert);
            popWinController = UIAlertController(title: "注意！",
                                                 message: "未能成功登入\n帳號密碼有誤！",
                                                 preferredStyle: UIAlertControllerStyle.alert);
            //準備迸現視窗的按鈕，使他有退出鈕
            var okButton:UIAlertAction
            okButton = UIAlertAction(title: "OK",
                                     style: UIAlertActionStyle.default,
                                     handler: nil);
            //加上按鈕入popWinController
            popWinController.addAction(okButton);
            //此時我們需要將畫面呈現在ViewController，但本calss只是一個Delegate，我們必須呼叫ViewController，故到上面去宣告一個ViewController來提供本calss轉換頁面呈現繃現視窗
            self.present(popWinController, animated: true, completion: nil);
            
            print("簽入出現問題")
            //把indicatorView關掉
            self.indicatorView.stopAnimating();
            return
        }
    }
    
}
