//
//  SignInViewController.swift
//  ElectionLoginDemo
//
//  Created by EZoneLai on 2017/2/10.
//  Copyright © 2017年 EZoneLai. All rights reserved.
//

import UIKit

class SignInViewController: myViewController, UITextFieldDelegate {
    var sexS:String = ""
    var ageValue:Int = 0
    
    
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var telephoneField: UITextField!
    
    @IBOutlet weak var sexSegment: UISegmentedControl!
    
    @IBOutlet weak var ageSlider: UISlider!
    
    @IBOutlet weak var ageLabel: UILabel!
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        // MARK: - 套用myController的返回鍵設定
        //自訂的標題
        self.setTitleAndBackTitle(title: "註冊個人資料", backTitle: "ㄑ上一頁", barColor: "entryColor")
        let titleView = UIImageView(frame: CGRect(x:0, y:0, width: 160, height: 40))
        titleView.contentMode = .scaleAspectFit
        titleView.image = self.appdelegate.logoImage
        self.navigationItem.titleView = titleView

    }
    override func viewWillDisappear(_ animated: Bool) {
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //性別選擇，預設 ""
    @IBAction func sexSegmentControl(_ sender: UISegmentedControl) {
        
        if(sexSegment.selectedSegmentIndex      == 0)
        {
            self.dismissKeyboard()
            sexS = "male"  //男性
        }
        else if(sexSegment.selectedSegmentIndex == 1)
        {
            self.dismissKeyboard()
            sexS = "female"  //女性
        }
        
    }
    
    //年齡選擇，預設 18
    @IBAction func ageControl(_ sender:AnyObject){
        
        let x = sender as? UIButton
        
        if let button = x {
           if button.titleLabel?.text! == " "{
                self.ageSlider.value = self.ageSlider.value + 1
           }else{
                self.ageSlider.value = self.ageSlider.value - 1
           }
        }
        
        //let s = sender as? UISlider
        //if let slider = s {print("value=\(slider.value)")}
        
        ageValue = Int(ageSlider.value)
        ageLabel.text = "民國 ： \(ageValue) 年次"
        
    }
    
    
    @IBAction func toLoginButton(_ sender: UIButton) {
        
        let nameString:String = nameField.text!
        let telephoneString:String = telephoneField.text!
        //MARK: - 將選的字傳回AppDelegate
        appdelegate.name = nameString
        appdelegate.telephone = telephoneString
        appdelegate.sex = sexS
        appdelegate.birth_year = ageValue + 1911
        //MARK: - 檢查資料
        if appdelegate.name         != "" &&
            appdelegate.telephone   != "" &&
            appdelegate.sex         != ""
        {
            //TODO: 如果給真實的姓名電話是否要提供誘因，社會工程等等
            
            performSegue(withIdentifier: "toLogin", sender: nil)
        }else{
            //TODO: 在此給一個彈出視窗，告知使用者該輸入的資料不完整。
            //做一個alert或pop蹦現視窗
            var popWinController:UIAlertController;
            //呼叫UIAlertController的一個建構子來製作物件(title『標題文字』: "警告",message『訊息文字』: "你輸入了一個限制字元",preferredStyle『迸現風格（他是一種preferredStyle列舉，此先使用alert風格）』: UIAlertControllerStyle.alert);
            popWinController = UIAlertController(title: "注意",
                                                 message: "資料不完整\n請輸入完整來進行下一步",
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
            //print("請完成必須資料")
        }
        print("此使用者的姓名：\(appdelegate.name)")
        print("此使用者的電話：\(appdelegate.telephone)")
        print("此使用者的性別：\(appdelegate.sex)")
        print("此使用者的年齡：\(appdelegate.birth_year)")
        
        
    }
    
    
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    // UITextField Delegate
    func handleTap() {
        dismissKeyboard()
    }
}
