//
//  RelationViewController.swift
//  ElectionLoginDemo
//
//  Created by EZoneLai Lai on 2017/4/10.
//  Copyright © 2017年 EZoneLai. All rights reserved.
//

import UIKit

class RelationViewController: myViewController, UITableViewDelegate, UITableViewDataSource  {

    //let fonts = UIFont.familyNames;
    //var lastIndexPath:IndexPath!;
    // MARK: - 宣告基礎變數常數
    
    
    @IBOutlet weak var tableView: UITableView!
    var relationFunc:[String] = [
        
        "團隊鐵票總數",
        "一級關係人數",
        "二級關係人數",
        "三級關係人數",
        "團隊助理固票排行",//顯示前30名
        "所有會員固票排行"//顯示前30名
        /* 後續要增加功能可列於此 */
        //"團隊顧問資料"//未來需要做出搜尋器，以及顯示人員加入時間
        
    ]
    
    // MARK: - 加入UITableViewDataSource
    //UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return relationFunc.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "relationCell", for: indexPath);
        cell.textLabel?.text = relationFunc[indexPath.row]
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
        let _:String = (relationFunc[indexPath.row])
        //TODO: 未來需要依照使用者購買來開啟功能
        
        //        if selectFunc == "留言板" {
        //            performSegue(withIdentifier: "board", sender: selectFunc)
        //        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - 宣告UITableViewDelegate
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.rowHeight = 50;
        
    }
    override func viewWillAppear(_ animated: Bool) {
        // MARK: - 套用myController的返回鍵設定
        //自訂的標題
        self.setMyTabBarTitleAndBackTitle(title: "檢視器", backTitle: "ㄑ回主頁", barColor: "mainColor")
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
