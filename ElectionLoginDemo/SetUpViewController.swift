//
//  SetUpViewController.swift
//  ElectionLoginDemo
//
//  Created by EZoneLai Lai on 2017/4/10.
//  Copyright © 2017年 EZoneLai. All rights reserved.
//

import UIKit

class SetUpViewController: myViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet weak var desktopImage: UIImageView!
    
    @IBOutlet weak var tableView: UITableView!
    
    var photoType:String = ""
    var setUpFunc:[String] = []
    var setUpFuncA:[String] = [
        "設定選擇主頁海報",
        "設定頭像",
        "設定候選人主頁頭像",
        "設定福利商家",
        "任命成員",
        "秘書任命",
        "設定支持",
        "啟動QR Code掃描"
        /* 後續要增加功能可列於此 */
    ]
    var setUpFuncB:[String] = [
        "設定頭像",
        "設定福利商家",
        "任命成員",
        "秘書任命",
        "設定支持",
        "啟動QR Code掃描"
        /* 後續要增加功能可列於此 */
    ]
    var setUpFuncC:[String] = [
        "設定選擇主頁海報",
        "設定頭像",
        "設定支持",
        "啟動QR Code掃描"
        /* 後續要增加功能可列於此 */
    ]
    
    var imagePicker:UIImagePickerController!
    var image:UIImage!

    
    
    // MARK: - 加入UITableViewDataSource
    //UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if appdelegate.user_type == "A"{
            setUpFunc = setUpFuncA;
        }else if appdelegate.user_type == "B"{
            setUpFunc = setUpFuncB;
        }else{
            setUpFunc = setUpFuncC;
        }
        return setUpFunc.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "setUpCell", for: indexPath);
        cell.textLabel?.textColor = UIColor.white
        cell.backgroundColor = UIColor.clear
        cell.textLabel?.textAlignment = .left
        cell.detailTextLabel?.textAlignment = .left
        cell.textLabel?.text = setUpFunc[indexPath.row]
        //cell.imageView?.image = platimum_member_picture[indexPath.row]
        //cell.accessoryType = UITableViewCellAccessoryType.checkmark
        return cell;
    }
    
    func numberOfSections(in tableView: UITableView) -> Int{
        return 1;
    }
    // MARK: - 加入UITableViewDelegate
    //UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let selectFunc:String = (setUpFunc[indexPath.row])
        //TODO: 未來需要依照使用者購買來開啟功能
        if selectFunc == "設定選擇主頁海報"{
            photoType = "setDesktop"
            performSegue(withIdentifier: "goSetPhoto", sender: selectFunc)
            
        };
        if selectFunc == "設定頭像"{
            photoType = "setUeserPhoto"
            performSegue(withIdentifier: "goSetPhoto", sender: selectFunc)
        };
        if selectFunc == "設定候選人主頁頭像"{
            photoType = "setAphoto"
            performSegue(withIdentifier: "goSetPhoto", sender: selectFunc)
        };
        if selectFunc == "啟動QR Code掃描"{
            // 換頁到QRReaderView 
            let QRReaderView = UIStoryboard(name: "Entry", bundle: nil).instantiateViewController(withIdentifier: "QRReaderView") as! QRReaderViewController
            navigationController?.pushViewController(QRReaderView, animated: true)
        };
        if selectFunc == "設定支持"{
            performSegue(withIdentifier: "goSetSupport", sender: selectFunc)
        };

        
    }
    
    //將選擇的支持者類型aType傳給下一個頁面
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let controller = segue.destination as? SetPhotoViewController
        controller?.photoType = photoType
        print("我選擇的拍照功能是\(photoType)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: - 調整頁面下推
        //self.definesPresentationContext = true
        self.edgesForExtendedLayout = [];
        //self.navigationController?.isNavigationBarHidden = true
        // MARK: - 宣告UITableViewDelegate
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.rowHeight = 60;
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        // MARK: - 套用myController的返回鍵設定
        //自訂的標題
        self.setTitleAndBackTitle(title: "控制台", backTitle: "ㄑ回主頁", barColor: "mainColor")
        let titleView = UIImageView(frame: CGRect(x:0, y:0, width: 160, height: 40))
        titleView.contentMode = .scaleAspectFit
        titleView.image = self.appdelegate.logoImage
        self.navigationItem.titleView = titleView
        //套用預設底圖
        if (appdelegate.desktopWallpaperImage != nil){
            desktopImage.image = appdelegate.desktopWallpaperImage
        }else{
            desktopImage.image = UIImage(named: "song510x732")
        }
    }
  

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
