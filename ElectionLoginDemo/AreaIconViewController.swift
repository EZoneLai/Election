//
//  AreaIconViewController.swift
//  ElectionLoginDemo
//
//  Created by EZoneLai on 2017/2/27.
//  Copyright © 2017年 EZoneLai. All rights reserved.
//

import UIKit

class AreaIconViewController: myViewController, UITableViewDataSource, AreaIconviewDelegate{
    /////AreaIconviewDelegate的東東
    //依照我們繼承的delegate內部的兩個變數，都必須在此實作
    var map_area:String!
    var choose:String!
    var base_view:UIView!
    
    ////////////////////////

    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.table.dataSource = self
        //在此更換地圖
        map_area  = "taiwan_area"
        //桃園市
        //map_area = "TaoyuanCityView"
        let area_to_show:[UIView] = Bundle.main.loadNibNamed(map_area, owner: self, options: nil) as! [UIView]
        
        
        base_view = area_to_show[0]
        
        let base_image = base_view.viewWithTag(1000) as! AreaIconView
        
        
        base_image.delegate = self
        
        //設定scrollView 的 contentSize
        self.scrollView.contentSize = base_view.frame.size //self.TaiwanImage.frame.size
        
        self.scrollView.addSubview(base_view)
        self.scrollView.showsVerticalScrollIndicator = false
        self.scrollView.showsHorizontalScrollIndicator = false
        //告訴controller自己的delegate
       // self.NewTaipeiCityImage.delegate = self

       // self.area_data = taiwan_area().taiwan_area_color
 
       // self.view_to_handle = self.NewTaipeiCityImage
       // self.tableview_to_update = UITableView()
            }
    
    override func viewWillAppear(_ animated: Bool) {
        // MARK: - 套用myController的返回鍵設定
        //自訂的標題
        self.setMyTabBarTitleAndBackTitle(title: "檢視器", backTitle: "ㄑ回主頁", barColor: "mainColor")
        
    }
    
    
    
    //////areaiconview function
 
    func enlarge(tag:Int){
 
        print("放大\(tag)")
        
        if let viewImages  = base_view.viewWithTag(tag) {
        
            let imageView = viewImages as! UIImageView
            
            let large_x = imageView.frame.origin.x - 7
            let large_y = imageView.frame.origin.y - 7
            let large_width = imageView.frame.size.width + 14
            let large_height = imageView.frame.size.height + 14
            
            imageView.frame = CGRect(x: large_x, y: large_y, width: large_width, height: large_height)
            
        }else{
            print("base_image.viewWithTag(tag) FAIL!!!")
        }
        
        
        
    }

    ////縮小功能(注意！！是放大參數傳進來的區域而不是自己)
    func shrink(tag:Int){
        print("還原\(tag)")
        
        if let viewImages  = base_view.viewWithTag(tag) {
            
            let imageView = viewImages as! UIImageView
            
            let origin_x = imageView.frame.origin.x + 7
            let origin_y = imageView.frame.origin.y + 7
            let origin_width = imageView.frame.size.width - 14
            let origin_height = imageView.frame.size.height - 14
            
            imageView.frame = CGRect(x: origin_x, y: origin_y, width: origin_width, height: origin_height)
            
        }else{
            print("base_image.viewWithTag(tag) FAIL!!!")
        }

        
        
        
    }
 
    ////寫入tableview
    func update_tableview(tableview:UITableView, which_area:String){
        //print("更新")
        //let meta = taiwan_area().taiwan_area_meta
        //let data = meta[which_area]! as String
        //self.show_data = data.components(separatedBy: ",")
        self.table.reloadData()
    }
 
    ////測試呼叫
    func test(){
        print("got it")
    }
    
    
    
    
    
 
//////tableview function
 
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0//self.show_data.count
    }
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        //cell.textLabel?.text = "\(show_data[indexPath.row])"
        return cell
    }
 
}
