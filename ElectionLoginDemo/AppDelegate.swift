//
//  AppDelegate.swift
//  ElectionLoginDemo
//
//  Created by EZoneLai on 2017/2/8.
//  Copyright © 2017年 EZoneLai. All rights reserved.
//

import UIKit




@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    //設定測試狀態的值
    static let flag:FLAG = FLAG(developing: true)
    var window: UIWindow?
    /////載入預設候選人class, 預設是公版
    var generic:Generic = Generic()
    /////設計四種候選人的按鈕和換頁
    var sumc:Int                       = 0//議員 member of congress (MC)
    var suhd:Int                       = 0//里長Head of District(HD)
    var suer:Int                       = 0//民意代表Elected Representatives(ER)
    var suml:Int                       = 0//立法委員Members of Legislative Yuan (ML)
    /////候選人的類型
    var supportedType:String            = ""
    /////全域變數
    var chose_Village_String:String     = ""
    var chose_Industry_String:String    = ""
    var city:String                     = ""
    var district:String                 = ""
    var village:String                  = ""
    var address:String                  = ""
    var adressTitle:String              = ""
    var occupation:String               = ""
    var account:String                  = ""
    var password:String                 = ""
    var name:String                     = ""
    var telephone:String                = ""
    var sex:String                      = ""
    var birth_year:Int                  = 0
    var guid:String                     = ""
    //"25CF4EC4-4617-4849-8ACD-2FD9EC103D37"
    ////B4C4A100-24BB-455D-A5FE-FF7F697CD669//測試用
    var sn_id:Int                       = 0
    var user_type:String                = "A"
    var device_token:String             = ""
    var upstream:Int                    = 0
    var leader_id:Int                   = 0
    var email:String                    = ""
    var campaign_type:String            = ""
    var device_type:String              = "iOS"
    var timePeriod:TimeInterval         = 10
    var logoImage:UIImage               = UIImage(named: "logo_1")!
    //var adImage:UIImage?                = nil
    var desktopWallpaperImage:UIImage?  = nil //使用者桌面
    var MCImage:UIImage?                = nil//使用者支持MC頭像
    var HDImage:UIImage?                = nil//使用者支持HD頭像
    var ERImage:UIImage?                = nil//使用者支持ER頭像
    var MLImage:UIImage?                = nil//使用者支持ML頭像
    var markController:UIViewController!
    //設計初始的登入註冊頁面與他的Navugation
    var startNav:UINavigationController!
    //因為D3js網頁還有問題，先暫用這個
    //var RelationD3jsView                = "http://127.0.0.1/trees/genD3jsview.php?"
    /////部屬的資料庫server ip
    var server_ip:String                = "twin.taipei"
    //var server_ip:String                = "192.168.43.110"//伺服器的
    //var server_ip:String                = "172.20.10.7" //手機的172.20.10.12
    //var server_ip:String                = "172.20.10.12"
    //var server_ip:String                = "127.0.0.1" //模擬器的
    //var server_ip:String = "192.168.0.70"
    //var server_ip:String = "10.96.18.61"
    
    /////以下是連外web位置設定
    //測試位置
    let test_side:String = "http://twin.taipei/app_test/upload"
    /////temp use
    //var under_construction_url:String   = "http://twin.taipei/temp"
    var under_construction_url:String = "http://127.0.0.1/discuz/upload/forum.php?forumlist=1&mobile=2"
    
    //初始大頭照
    var defaultHead:UIImage? = nil;
    //初始大頭照大小
    var defaultHeadSize:CGSize? = nil
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
    
        //做出初始nav頁面
        startNav = UIStoryboard(name: "Entry", bundle: nil).instantiateViewController(withIdentifier: "StartNavgation") as! UINavigationController
        self.window?.rootViewController = startNav
        self.window?.makeKeyAndVisible()
        //自訂整個app的字型顏色等等外觀設定
        // 設定statusbar為透明
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
        let navigationBarAppearace = UINavigationBar.appearance()
        navigationBarAppearace.tintColor = UIColor.white
        navigationBarAppearace.barTintColor = UIColor.clear
        navigationBarAppearace.isTranslucent = true
        navigationBarAppearace.titleTextAttributes = [
            NSForegroundColorAttributeName:UIColor.white,
            NSFontAttributeName: UIFont(name: "Helvetica Neue", size: 22.0)!
        ]
        startNav.view.backgroundColor = UIColor.clear
        //其他可用字型
        //Arial
        //先將廣告頁面放入StartNavigaion
        let bufferView = BufferController(nibName: "BufferView", bundle: nil)
        startNav.pushViewController(bufferView, animated: true)
        
        
        //加入以下4行，做token
        
        let notificationTypes: UIUserNotificationType = [UIUserNotificationType.alert, UIUserNotificationType.badge, UIUserNotificationType.sound]
        
        let pushNotificationSettings = UIUserNotificationSettings(types: notificationTypes, categories: nil)
        
        application.registerUserNotificationSettings(pushNotificationSettings)
        
        application.registerForRemoteNotifications()
        
        
        //辨識設備的類型
        let deviceClass = UIDevice()
        device_type = deviceClass.model
        //print(device_type)
        //指定沙箱路徑
        let already_path:String = NSHomeDirectory() + "/Documents/already.data"
        let default_head_path:String = NSHomeDirectory() + "/Documents/default.png"
        print("本機端驗證檔案的儲存路徑：\(already_path)")
        let manager:FileManager = FileManager.default
        ////程式全域用圖(儲藏在沙箱)，先套用generic內的紀錄檔，就是預設頭像
        if manager.fileExists(atPath: default_head_path){
            //如果有其他路徑，載入之
            //TODO: 此處要再確認，頭像路徑和取得方式
            self.generic.defaultHead = UIImage(contentsOfFile: default_head_path)
            
            //self.default_head = UIImage(contentsOfFile: default_head_path)
        }else{
            self.generic.defaultHead = UIImage(named: "default");
            
        }
        
        return true
    }
    
    
    
    
    //////////////////////////////////////////
    ///////////推播需要實作的三個 func
    
    // Called when APNs has assigned the device a unique token
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // Convert token to string
        //TODO: 如果沒有拿到 deviceToken 要再處理
        
        device_token = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
        
        // Print it to console
        print("APNs device token: \(device_token)")
        
        ////////把這隻手機allow push Notification 所得之 device_token 上傳去sql確認
        //TODO: 把device_token拿去伺服器比對是否相同，若不同，則將already.data檔案刪除
        
        
        
        
        // Persist it in your backend in case it's new
    }
    
    // Called when APNs failed to register the device for push notifications
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        // Print the error to console (you should alert the user that registration failed)
        print("APNs registration failed: \(error)")
    }
    
    // Push notification received
    func application(_ application: UIApplication, didReceiveRemoteNotification data: [AnyHashable : Any]) {
        // Print notification payload data
        print("Push notification received: \(data)")
    }

    //////////////////////////////////////////
    //以上是推播的 func 2017.05.08
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
   
        
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        print("GGGGGGGG")
    }
    
    
}

extension UIViewController {
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    func buttonAdjustsFontSizeToFitWidth() -> UIButton {
        let button = UIButton.init()
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.minimumScaleFactor = 0.5
        return button
    }
    func buttonAdjust(target: [UIButton]){
        for button in target {
            button.titleLabel?.adjustsFontSizeToFitWidth = true
            button.titleLabel?.numberOfLines = 1
            button.titleLabel?.minimumScaleFactor = 0.5
        }
    }
    func labelAdjust(target: [UILabel]){
        for label in target {
            label.adjustsFontSizeToFitWidth = true
            //label.numberOfLines = 0
            //label.minimumScaleFactor = 0.5
        }
    }
    func textFieldAdjust(target: [UITextField]) {
        for textfield in target {
            textfield.adjustsFontSizeToFitWidth = true
            textfield.minimumFontSize = 12
        }
    }
    func numberKeyboard(target: [UITextField]) {
        for textfield in target {
            textfield.keyboardType = .numberPad
            textfield.minimumFontSize = 12
        }
    }
    func getCurrentLocalDate() -> Date {
        var now = Date()
        var nowComponents = DateComponents()
        let calendar = Calendar.current
        nowComponents.year = Calendar.current.component(.year, from: now)
        nowComponents.month = Calendar.current.component(.month, from: now)
        nowComponents.day = Calendar.current.component(.day, from: now)
        nowComponents.hour = Calendar.current.component(.hour, from: now)
        nowComponents.minute = Calendar.current.component(.minute, from: now)
        nowComponents.second = Calendar.current.component(.second, from: now)
        nowComponents.timeZone = TimeZone(abbreviation: "GMT")!
        now = calendar.date(from: nowComponents)!
        return now as Date
    }
    func popAlertWindow(title: String?, item: String? ) {
        var pop_win_controller:UIAlertController
        
        pop_win_controller = UIAlertController(
            title: title,
            message: item,
            preferredStyle:UIAlertControllerStyle.alert
        )
        
        var ok_button:UIAlertAction
        ok_button = UIAlertAction(
            title: "確定",
            style: UIAlertActionStyle.default,
            handler: nil
        )
        pop_win_controller.addAction(ok_button)
        self.present(pop_win_controller, animated: true, completion: nil)
    }
}

