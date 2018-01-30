//
//  UpgradeViewController.swift
//  ElectionLoginDemo
//
//  Created by EZoneLai Lai on 2017/4/3.
//  Copyright © 2017年 EZoneLai. All rights reserved.
//

import UIKit

class UpgradeViewController: myViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    

    var upgradeFunc:[String] = [
        
        "升級成助理",
        "升級成候選人",
        
        /* 後續要增加功能可列於此 */
    ]
    
    // MARK: - 加入UITableViewDataSource
    //UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return upgradeFunc.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "upgradeCell", for: indexPath);
        cell.textLabel?.textColor = UIColor.white
        cell.backgroundColor = UIColor.clear
        cell.textLabel?.textAlignment = .left
        cell.detailTextLabel?.textAlignment = .left
        cell.textLabel?.text = upgradeFunc[indexPath.row]
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
        let selectFunc:String = (upgradeFunc[indexPath.row])
        //TODO: 未來需要依照使用者購買來開啟功能
        
        
        if selectFunc == "升級成助理"{
            performSegue(withIdentifier: "goUpgradeB", sender: selectFunc)
            //可以升級控制台
            //控制台內連到外部網頁的契約書，請助理同意
        }
        if selectFunc == "升級成候選人"{
            performSegue(withIdentifier: "goUpgradeA", sender: selectFunc)
            //候選人可以升級兩種
            //一級控制台
            //二級控制台
            //控制台內連到外部網頁的契約書，請候選人同意
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        // MARK: - 套用myController的返回鍵設定
        //自訂的標題
        self.setMyTabBarTitleAndBackTitle(title: "工具箱", backTitle: "ㄑ回主頁", barColor: "mainColor")
        
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
