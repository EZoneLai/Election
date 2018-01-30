//
//  DistrictViewController.swift
//  ElectionLoginDemo
//
//  Created by EZoneLai on 2017/2/18.
//  Copyright © 2017年 EZoneLai. All rights reserved.
//

import UIKit

class DistrictViewController: myViewController, UITableViewDelegate, UITableViewDataSource {
    // MARK: - 宣告基礎變數常數

    @IBOutlet weak var districtTableView: UITableView!
    var districts:[String] = [
        "桃園區",
        "龜山區",
        "八德區",
        "大溪區",
        "蘆竹區",
        "大園區",
        "中壢區",
        "龍潭區",
        "平鎮區",
        "楊梅區",
        "新屋區",
        "觀音區",
        "復興區"
        ]
    
    // MARK: - 加入UITableViewDataSource
    //UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return districts.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "districtCell", for: indexPath);
        cell.textLabel?.textColor = UIColor.white
        cell.backgroundColor = UIColor.clear
        cell.textLabel?.textAlignment = .left
        cell.detailTextLabel?.textAlignment = .left
        cell.textLabel?.text = districts[indexPath.row]
        
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
        let selectDistrict:String = (districts[indexPath.row])
        ////將選的字傳回AppDelegate
        appdelegate.district = selectDistrict
        performSegue(withIdentifier: "goVillage", sender: selectDistrict)
        print("你選了：\(appdelegate.district)")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: - 調整頁面下推
        //self.definesPresentationContext = true
        //edgesForExtendedLayout = [];
        
        // MARK: - 宣告UITableViewDelegate
        districtTableView.delegate = self;
        districtTableView.dataSource = self;
        districtTableView.rowHeight = 60;
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        // MARK: - 套用myController的返回鍵設定
        //自訂的標題
        self.setTitleAndBackTitle(title: "選擇區", backTitle: "ㄑ上一頁", barColor: "entryColor")
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
