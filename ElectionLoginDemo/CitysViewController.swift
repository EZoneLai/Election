//
//  CitysViewController.swift
//  ElectionLoginDemo
//
//  Created by EZoneLai on 2017/2/15.
//  Copyright © 2017年 EZoneLai. All rights reserved.
//

import UIKit

enum Area:String{
    case 臺北市 = "taipei"
    case 新北市 = "newTaipei"
    case 新竹市 = "XiZu"
    case 桃園市 = "TouYuan"
}
enum Areas{
    case taipiei, newTaipei, thea, theb;
}

class CitysViewController: myViewController, UITableViewDelegate, UITableViewDataSource {
    // MARK: - 宣告基礎變數常數
    

    @IBOutlet weak var cityTableView: UITableView!
    var cityCounty:[String] = [
        "臺北市",
        "新北市",
        "基隆市",
        "桃園市",
        "新竹市",
        "新竹縣",
        "苗栗縣",
        "彰化縣",
        "雲林縣",
        "嘉義市",
        "嘉義縣",
        "臺中市",
        "南投縣",
        "臺南市",
        "高雄市",
        "屏東縣",
        "宜蘭縣",
        "花蓮縣",
        "臺東縣",
        "澎湖縣",
        "金門縣",
        "連江縣"
        ]
    
    // MARK: - 加入UITableViewDataSource
    //UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return cityCounty.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath);
        cell.textLabel?.textColor = UIColor.white
        cell.backgroundColor = UIColor.clear
        cell.textLabel?.textAlignment = .left
        cell.detailTextLabel?.textAlignment = .left
        cell.textLabel?.text = cityCounty[indexPath.row]
        
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
        let selectCity:String = (cityCounty[indexPath.row])
        ////將選的字傳回AppDelegate
        appdelegate.city = selectCity
        performSegue(withIdentifier: "goDistrict", sender: selectCity)
        print("你選了：\(appdelegate.city)")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: - 調整頁面下推
        //self.definesPresentationContext = true
        //edgesForExtendedLayout = [];
        
        // MARK: - 宣告UITableViewDelegate
        cityTableView.delegate = self;
        cityTableView.dataSource = self;
        cityTableView.rowHeight = 60;
      
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        // MARK: - 套用myController的返回鍵設定
        //自訂的標題
        self.setTitleAndBackTitle(title: "選擇縣市", backTitle: "ㄑ上一頁", barColor: "clearColor")
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


