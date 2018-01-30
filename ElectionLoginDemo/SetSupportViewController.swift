//
//  SetSupportViewController.swift
//  ElectionLoginDemo
//
//  Created by EZoneLai Lai on 2017/5/15.
//  Copyright © 2017年 EZoneLai. All rights reserved.
//

import UIKit

class SetSupportViewController: myViewController, UITableViewDelegate, UITableViewDataSource {
    // MARK: - 宣告基礎變數常數
    
    @IBOutlet weak var desktopImage: UIImageView!
    
    @IBOutlet weak var selectSupportListTableView: UITableView!
    //議員 member of congress (MC)
    var SupportList:[String] = [
        "選擇議員",
        "選擇里長",
        "選擇民代",
        "選擇立委"
    ]
    var aType = ""
    // MARK: - 加入UITableViewDataSource
    //UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return SupportList.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "supportCell", for: indexPath);
        cell.textLabel?.textColor = UIColor.white
        cell.backgroundColor = UIColor.clear
        cell.textLabel?.textAlignment = .left
        cell.detailTextLabel?.textAlignment = .left
        cell.textLabel?.text = SupportList[indexPath.row]
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
        let selectSupport:String = (SupportList[indexPath.row])
        if selectSupport == "選擇議員"{aType = "MC"};
        if selectSupport == "選擇里長"{aType = "HD"};
        if selectSupport == "選擇民代"{aType = "ER"};
        if selectSupport == "選擇立委"{aType = "ML"};
        performSegue(withIdentifier: "goSupportList", sender: selectSupport)
    }
    //將選擇的支持者類型aType傳給下一個頁面
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = segue.destination as? SupportListViewController
        controller?.aType = aType
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.appdelegate.markController = self
        
        //改掉按鈕的字
        //let MLButtonName = ListName + " 立委"
        
        
        
        //MARK: - 調整頁面下推
        //self.definesPresentationContext = true
        edgesForExtendedLayout = [];
        
        // MARK: - 宣告UITableViewDelegate
        selectSupportListTableView.delegate = self;
        selectSupportListTableView.dataSource = self;
        selectSupportListTableView.rowHeight = 60;
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        // MARK: - 套用myController的返回鍵設定
        //自訂的標題
        self.setTitleAndBackTitle(title: "選擇支持", backTitle: "ㄑ上一頁", barColor: "mainColor")
        //套用預設底圖
        if (appdelegate.desktopWallpaperImage != nil){
            desktopImage.image = appdelegate.desktopWallpaperImage
        }else{
            desktopImage.image = UIImage(named: "song510x732")
        }
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        
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

