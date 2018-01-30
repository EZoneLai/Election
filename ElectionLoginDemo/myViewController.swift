//
//  myViewController.swift
//  ElectionLoginDemo
//
//  Created by EZoneLai on 2017/2/16.
//  Copyright © 2017年 EZoneLai. All rights reserved.
//

import UIKit

class myViewController: UIViewController, UINavigationBarDelegate {
    //做一個appdelegate他是AppDelegate
    var appdelegate:AppDelegate!
    //var entryColor = UIColor(colorLiteralRed: 0.149, green: 0.177, blue: 0.243, alpha: 0.8)
    var entryColor = UIColor(colorLiteralRed: 0, green: 0, blue: 0, alpha: 0.1)
    //var mainColor = UIColor(colorLiteralRed: 0.2, green: 0.2, blue: 0.2, alpha: 0.8)
    var mainColor = UIColor(colorLiteralRed: 0, green: 0, blue: 0, alpha: 0.1)
    var clearColor = UIColor.clear
    var navigationBarImage:UIImage = UIImage(named: "bar_1")!
    var navigationTitleViewImage:UIImage = UIImage(named: "logo_1")!
    
    // MARK: - 設定自訂的各種UI外觀
    override func viewDidLoad() {
        super.viewDidLoad()
        //做一個appdelegate來代替UIApplication提高效能
        appdelegate = UIApplication.shared.delegate as! AppDelegate
        
        
    }

    override func viewWillAppear(_ animated: Bool) {
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        //MARK:- 開啟MultipleTouchEnabled
        self.view.isMultipleTouchEnabled = true
        
        //self.view.isExclusiveTouch = true
        //做一個兩只觸碰的物件來做一個函數動作touchAction，將這個函數寫在下面
        let twoFingersTap = UITapGestureRecognizer(target: self, action: #selector(touchAction))
        twoFingersTap.numberOfTouchesRequired = 2
        view.addGestureRecognizer(twoFingersTap)
    }
    //自訂觸碰函數touchAction
    func touchAction(recognizer: UITapGestureRecognizer) {
        print("雙指觸屏！彈出QRCode讓人刷")
        let controller = storyboard?.instantiateViewController(withIdentifier: "showQREveryWhere") as! popQRCodeViewController
        self.present(controller, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
    }
    override func viewDidDisappear(_ animated: Bool) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    

    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    
    //
    
    // MARK: - 建立自訂的NavigationButtonTitle函數
    func setTitleAndBackTitle(title:String, backTitle:String, barColor:String){
        self.navigationItem.title = title
        self.navigationController?.navigationBar.setBackgroundImage(navigationBarImage, for: .default)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: backTitle,
            style: UIBarButtonItemStyle.done,
            target: self,
            action: #selector(myViewController.push_button(_:))
        )
        //自訂整個app的字型顏色等等外觀設定
        let navigationBarAppearace = UINavigationBar.appearance()
        navigationBarAppearace.isTranslucent = true
        navigationBarAppearace.tintColor = UIColor.white
        var setBarColor = UIColor.clear
        if barColor == "entryColor"{setBarColor = entryColor}
        if barColor == "mainColor"{setBarColor = mainColor}
        if barColor == "clearColor"{setBarColor = clearColor}
        self.navigationController?.navigationBar.barTintColor = setBarColor
        navigationBarAppearace.titleTextAttributes = [
            NSForegroundColorAttributeName:UIColor.white,
            NSFontAttributeName: UIFont(name: "Helvetica-Bold", size: 22.0)!
        ]
        //print("testTieleChange\(title)")
    }
    // MARK: - 建立自訂的NavigationButtonTitleView函數
    func setTitleViewAndBackTitle(titleView:UIImageView, backTitle:String, barColor:String){
        self.navigationController?.navigationItem.titleView = titleView
        self.navigationController?.navigationBar.setBackgroundImage(navigationBarImage.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: .stretch), for: .default)
        //self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: backTitle,
            style: UIBarButtonItemStyle.done,
            target: self,
            action: #selector(myViewController.push_button(_:))
        )
        //自訂整個app的字型顏色等等外觀設定
        let navigationBarAppearace = UINavigationBar.appearance()
        navigationBarAppearace.isTranslucent = true
        navigationBarAppearace.tintColor = UIColor.white
        var setBarColor = UIColor.clear
        if barColor == "entryColor"{setBarColor = entryColor}
        if barColor == "mainColor"{setBarColor = mainColor}
        if barColor == "clearColor"{setBarColor = clearColor}
        self.navigationController?.navigationBar.barTintColor = setBarColor
        navigationBarAppearace.titleTextAttributes = [
            NSForegroundColorAttributeName:UIColor.white,
            NSFontAttributeName: UIFont(name: "Helvetica-Bold", size: 22.0)!
        ]
        //print("testTieleChange\(title)")
    }

    func push_button(_:UIBarButtonItem){
        self.navigationController?.popViewController(animated: true)
    }
    // MARK: - 建立自訂的TabBarNavigationButtonTitle函數
    func setMyTabBarTitleAndBackTitle(title:String, backTitle:String, barColor:String){
        self.tabBarController?.navigationController?.navigationBar.setBackgroundImage(navigationBarImage, for: .default)
        self.tabBarController?.navigationItem.title = title
        self.tabBarController?.navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: backTitle,
            style: UIBarButtonItemStyle.done,
            target: self,
            action: #selector(myViewController.myTabBarButton(_:))
        )
        //自訂整個app的字型顏色等等外觀設定
        //設定上面的navigationbar
        let navigationBarAppearace = UINavigationBar.appearance()
        navigationBarAppearace.isTranslucent = true
        navigationBarAppearace.tintColor = UIColor.white
        var setBarColor = UIColor.clear
        if barColor == "entryColor"{setBarColor = entryColor}
        if barColor == "mainColor"{setBarColor = mainColor}
        if barColor == "clearColor"{setBarColor = clearColor}
        self.navigationController?.navigationBar.barTintColor = setBarColor
        navigationBarAppearace.titleTextAttributes = [
            NSForegroundColorAttributeName:UIColor.white,
            NSFontAttributeName: UIFont(name: "Helvetica-Bold", size: 22.0)!
        ]
        //設定下面的tabbar
        self.tabBarController?.tabBar.tintColor = UIColor.white
        self.tabBarController?.tabBar.barTintColor = setBarColor
        let tabBarAppearace = UITabBarItem.appearance()
        tabBarAppearace.setTitleTextAttributes([NSFontAttributeName:UIFont(name: "HelveticaNeue-Bold", size: 24.0)!], for: .selected)
        tabBarAppearace.setTitleTextAttributes([NSFontAttributeName:UIFont(name: "Helvetica Neue", size: 16.0)!], for: .normal)
        
        //print("testTabBarTieleChange\(title)")
    }
    func myTabBarButton(_:UIBarButtonItem){
        self.tabBarController!.navigationController?.popViewController(animated: true)
    }
    
}
