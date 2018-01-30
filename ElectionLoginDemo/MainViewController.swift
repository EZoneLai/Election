//
//  MainViewController.swift
//  ElectionLoginDemo
//
//  Created by EZoneLai on 2017/2/14.
//  Copyright © 2017年 EZoneLai. All rights reserved.
//

import UIKit
class MainViewController: myViewController, UITableViewDelegate, UITableViewDataSource {
    //let fonts = UIFont.familyNames;
    //var lastIndexPath:IndexPath!;
    // MARK: - 宣告基礎變數常數
    //TODO: 得預先抓取該頁所屬候選人的資料
    
    @IBOutlet weak var desktopImage: UIImageView!

    @IBOutlet weak var anonymousImageView: UIImageView!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    //預設功能列表為空，依照下列，使用者的身分來給予功能
    var mainFunc:[String] = []
    
    var mainFuncA:[String] = [
        "服務公告",
        "檢視器",
        "緊急事件處理",
        "控制台",
        "工具箱",
        "留言板",
        "選情資訊",
        "電話簿",
        "話術輯",
        "測試頁"
        /* 後續要增加功能可列於此 */
    ]
    var mainFuncB:[String] = [
        "服務公告",
        "檢視器",
        "緊急事件處理",
        "控制台",
        "工具箱",
        "留言板",
        "選情資訊",
        "電話簿",
        "話術輯"
        /* 後續要增加功能可列於此 */
    ]
    var mainFuncC:[String] = [
        "服務公告",
        "檢視器",
        "緊急事件處理",
        "控制台",
        "工具箱"
        /* 後續要增加功能可列於此 */
    ]
    
    
    // MARK: - 加入UITableViewDataSource
    //UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if appdelegate.user_type == "A"{
            mainFunc = mainFuncA;
        }else if appdelegate.user_type == "B"{
            mainFunc = mainFuncB;
        }else{
            mainFunc = mainFuncC;
        }
        return mainFunc.count;
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell_main", for: indexPath);
        cell.textLabel?.textColor = UIColor.white
        cell.backgroundColor = UIColor.clear
        cell.textLabel?.text = mainFunc[indexPath.row]
        cell.textLabel?.textAlignment = .left
        cell.detailTextLabel?.textAlignment = .left
        
        //cell.backgroundColor = UIColor.cyan
        //cell.imageView?.image = platimum_member_picture[indexPath.row]
        //cell.detailTextLabel?.text = platimum_member_year[indexPath.row]
        //cell.accessoryType = UITableViewCellAccessoryType.checkmark
        return cell;
    }
    
    func numberOfSections(in tableView: UITableView) -> Int{
        return 1;
    }
    // MARK: - 加入UITableViewDelegate
    //UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let selectFunc:String = (mainFunc[indexPath.row])
        //TODO: 未來需要依照使用者購買來開啟功能
        
        if selectFunc == "服務公告"{
            performSegue(withIdentifier: "announcement", sender: selectFunc)
        };
        
        if selectFunc == "檢視器"{
            if appdelegate.user_type == "A"{
                performSegue(withIdentifier: "viewer", sender: selectFunc)
            }else{
                performSegue(withIdentifier: "goHomePage", sender: selectFunc)
            }
        };
        if selectFunc == "緊急事件處理"{
            performSegue(withIdentifier: "emergency", sender: selectFunc)
        };
        if selectFunc == "控制台"{
            performSegue(withIdentifier: "setUp", sender: selectFunc)
        };
        if selectFunc == "工具箱"{
            performSegue(withIdentifier: "toolbox", sender: selectFunc)
            
        };
        if selectFunc == "留言板"{
            performSegue(withIdentifier: "publicOpinion", sender: selectFunc)
        };
        if selectFunc == "選情資訊"{
            performSegue(withIdentifier: "information", sender: selectFunc)
        };
        if selectFunc == "電話簿"{
            performSegue(withIdentifier: "goContactView", sender: selectFunc)
        };
        if selectFunc == "話術輯"{
            performSegue(withIdentifier: "goManuscript", sender: selectFunc)
        };
        if selectFunc == "測試頁"{
            let startNav:UINavigationController = self.navigationController!
            let testView = UIStoryboard(name: "Entry", bundle: nil).instantiateViewController(withIdentifier: "test") as! TestViewController
            startNav.pushViewController(testView, animated: true)
        }
        
        //另一種換頁方式，留用
        //        if ((tableView.indexPathForSelectedRow?.item) == 0) {
        //            self.performSegue(withIdentifier: "board", sender: nil)
        //        }
        //        if ((tableView.indexPathForSelectedRow?.item) == 1) {
        //            self.performSegue(withIdentifier: "server", sender: nil)
        //        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // MARK: - 宣告UITableViewDelegate
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.rowHeight = 60;
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // MARK: - 套用myController的返回鍵設定
        //自訂的標題
        self.setTitleAndBackTitle(title: "＝TWINS 鐵 票", backTitle: "ㄑ返回", barColor: "mainColor")
        let titleView = UIImageView(frame: CGRect(x:0, y:0, width: 160, height: 40))
        titleView.contentMode = .scaleAspectFit
        titleView.image = self.appdelegate.logoImage
        self.navigationItem.titleView = titleView
        
    }
    override func viewDidAppear(_ animated: Bool) {
        //套用預設底圖
        if (appdelegate.desktopWallpaperImage != nil){
            desktopImage.image = appdelegate.desktopWallpaperImage
        }else{
            desktopImage.image = UIImage(named: "song510x732")
        }
        //套用圖形大小
        self.appdelegate.generic.defaultHeadSize = CGSize(width: anonymousImageView.frame.size.width, height: anonymousImageView.frame.size.height)
        ////先判斷現在的頁面是屬於 MC HD ER ML 哪一種？
        //去判斷MCImage...等，候選人的頭像是否為空，有圖就給他
        //如果為空就套用頭像預設照片
        if (appdelegate.supportedType == "MC"){
            if (appdelegate.MCImage != nil){
                anonymousImageView.image = appdelegate.MCImage
            }else{
                anonymousImageView.image = appdelegate.generic.defaultHead
            }
        }else if(appdelegate.supportedType == "HD"){
            if (appdelegate.HDImage != nil){
                anonymousImageView.image = appdelegate.HDImage
            }else{
                anonymousImageView.image = appdelegate.generic.defaultHead
            }
        }else if(appdelegate.supportedType == "ER"){
            if (appdelegate.ERImage != nil){
                anonymousImageView.image = appdelegate.ERImage
            }else{
                anonymousImageView.image = appdelegate.generic.defaultHead
            }
        }else if(appdelegate.supportedType == "ML"){
            if (appdelegate.MLImage != nil){
                anonymousImageView.image = appdelegate.MLImage
            }else{
                anonymousImageView.image = appdelegate.generic.defaultHead
            }
        }else{
            anonymousImageView.image = appdelegate.generic.defaultHead
        }
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        // MARK: - 套用myController的返回鍵設定
        //自訂的標題
        self.setTitleAndBackTitle(title: "返回", backTitle: "", barColor: "mainColor")
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    /*
     //  MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     
     }
     */
    
}



