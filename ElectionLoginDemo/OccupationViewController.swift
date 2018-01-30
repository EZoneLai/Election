//
//  IndustryViewController.swift
//  ElectionLoginDemo
//
//  Created by EZoneLai on 2017/2/15.
//  Copyright © 2017年 EZoneLai. All rights reserved.
//

import UIKit

class OccupationViewController: myViewController, UITableViewDelegate, UITableViewDataSource {
    // MARK: - 宣告基礎變數常數
    
    @IBOutlet weak var occupationTableView: UITableView!
    var occupationName:String = "請選擇行業"
    var occupations:[String] = [
        "軍",
        "公",
        "教",
        "農",
        "工",
        "商"
        ]
    // MARK: - 加入UITableViewDataSource
    //UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return occupations.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "occupationsCell", for: indexPath);
        cell.textLabel?.textColor = UIColor.white
        cell.backgroundColor = UIColor.clear
        cell.textLabel?.textAlignment = .left
        cell.detailTextLabel?.textAlignment = .left
        cell.textLabel?.text = occupations[indexPath.row]
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
        let selectOccupation:String = (occupations[indexPath.row])
        self.occupationName = selectOccupation
        ////將選的字傳回AppDelegate
        appdelegate.occupation = occupationName
        print("職業是：\(appdelegate.occupation)職")
        self.navigationController!.popViewController(animated: true)
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: - 調整頁面下推
        //self.definesPresentationContext = true
        //edgesForExtendedLayout = [];
        
        // MARK: - 宣告UITableViewDelegate
        occupationTableView.delegate = self;
        occupationTableView.dataSource = self;
        occupationTableView.rowHeight = 60;
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        // MARK: - 套用myController的返回鍵設定
        //自訂的標題
        
        self.setTitleAndBackTitle(title: "選擇職業", backTitle: "ㄑ上一頁", barColor: "clearColor")
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
        /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
