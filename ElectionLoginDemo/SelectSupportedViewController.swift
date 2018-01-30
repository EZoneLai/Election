//
//  SelectSupportedViewController.swift
//  ElectionLoginDemo
//
//  Created by EZoneLai Lai on 2017/5/15.
//  Copyright © 2017年 EZoneLai. All rights reserved.
//

import UIKit

class SelectSupportedViewController: myViewController {

    var startNav:UINavigationController!
    
    @IBOutlet weak var backImage: UIImageView! //for self.appdelegate.userBackImage
    
    @IBOutlet weak var MCButtonTitle: UIButton!
    
    @IBOutlet weak var HDButtonTitle: UIButton!
    
    @IBOutlet weak var ERButtonTitle: UIButton!
    
    @IBOutlet weak var MLButtonTitle: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func viewWillAppear(_ animated: Bool) {
        
        // MARK: - 套用myController的返回鍵設定
        //自訂的標題
        self.setTitleAndBackTitle(title: "＝TWINS 鐵 票", backTitle: "", barColor: "mainColor")
        let titleView = UIImageView(frame: CGRect(x:0, y:0, width: 160, height: 40))
        titleView.contentMode = .scaleAspectFit
        titleView.image = self.appdelegate.logoImage
        self.navigationItem.titleView = titleView
        //關閉返回按鈕的功能
        self.navigationItem.leftBarButtonItem?.isEnabled = false
        
        
        //將得到的底圖，給這裡的底圖
        if (self.appdelegate.desktopWallpaperImage != nil){
            self.backImage.image = self.appdelegate.desktopWallpaperImage
        }
        //TODO:嘗試改成黑色底色的navigationBar和Helvetica Neue字型，因為這裡不寫，他並沒有完成繼承myViewController的設定
        //測試結果，這一頁是navigationBar的起點
        /*
        self.navigationController?.navigationBar.barTintColor = UIColor(colorLiteralRed: 0.2, green: 0.2, blue: 0.2, alpha: 0)
        let navBarControll = UINavigationBar.appearance()
        navBarControll.isTranslucent = true
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSForegroundColorAttributeName:UIColor.white,
            NSFontAttributeName: UIFont(name: "Helvetica Neue", size: 22.0)!
        ]*/

    }
    override func viewWillDisappear(_ animated: Bool) {
        //TODO: 之後可以在這裡改navigationBar
    }
    
    //議員 member of congress (MC)
    @IBAction func MCButton(_ sender: UIButton) {
        //MARK:- 確認身分後使使用者回到首頁
        appdelegate.supportedType = "MC"
        
        //依照MC去抓取，sumc的sn_id，然後去伺服器抓該候選人的資料下來
        startNav = self.navigationController
        let selectView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainController") as! MainViewController
        startNav.pushViewController(selectView, animated: true)

        
    }
    
    //里長Head of Destrict(HD)
    @IBAction func HDButton(_ sender: UIButton) {
        //MARK:- 確認身分後使使用者回頁
        appdelegate.supportedType = "HD"
        startNav = self.navigationController
        let selectView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainController") as! MainViewController
        startNav.pushViewController(selectView, animated: true)
        
    }
    
    //民意代表Elected Representatives(ER)
    @IBAction func ERButton(_ sender: UIButton) {
        //MARK:- 確認身分後使使用者回到首頁
        appdelegate.supportedType = "ER"
        startNav = self.navigationController
        let selectView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainController") as! MainViewController
        startNav.pushViewController(selectView, animated: true)
        
    }
    
    //立法委員Members of Legislative Yuan (MLY)
    @IBAction func MLYButton(_ sender: UIButton) {
        //MARK:- 確認身分後使使用者回到首頁
        appdelegate.supportedType = "ML"
        startNav = self.navigationController
        let selectView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainController") as! MainViewController
        startNav.pushViewController(selectView, animated: true)
        
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
