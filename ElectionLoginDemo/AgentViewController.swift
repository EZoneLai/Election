//
//  AgentViewController.swift
//  ElectionLoginDemo
//
//  Created by EZoneLai Lai on 2017/4/3.
//  Copyright © 2017年 EZoneLai. All rights reserved.
//

import UIKit

class AgentViewController: myViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    var upgradeBFunc:[String] = [
        
        "助理工具",
        
        
        /* 後續要增加功能可列於此 */
    ]
    
    // MARK: - 加入UITableViewDataSource
    //UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return upgradeBFunc.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "upgradeCellB", for: indexPath);
        cell.textLabel?.textColor = UIColor.white
        cell.backgroundColor = UIColor.clear
        cell.textLabel?.textAlignment = .left
        cell.detailTextLabel?.textAlignment = .left
        cell.textLabel?.text = upgradeBFunc[indexPath.row]
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
        let selectFunc:String = (upgradeBFunc[indexPath.row])
        //TODO: 未來需要依照使用者購買來開啟功能
        
        
        if selectFunc == "助理工具"{
            //performSegue(withIdentifier: "announcement", sender: selectFunc)
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //MARK: - 調整頁面下推
        //self.definesPresentationContext = true
        edgesForExtendedLayout = [];

        // MARK: - 宣告UITableViewDelegate
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.rowHeight = 60;
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        // MARK: - 關閉MainView的navigation
        //因為銜接了tabBar所以必須把他關係到naviagtion才能改
        //在自己自訂naviagtion的標題
        self.tabBarController?.navigationController?.isNavigationBarHidden = true;
        self.setTitleAndBackTitle(title: "", backTitle: "ㄑ上一頁", barColor: "mainColor")
        let titleView = UIImageView(frame: CGRect(x:0, y:0, width: 160, height: 40))
        titleView.contentMode = .scaleAspectFit
        titleView.image = self.appdelegate.logoImage
        self.navigationItem.titleView = titleView
    }
    override func viewWillDisappear(_ animated: Bool) {
        // MARK: - 開啟MainView的navigation
        //因為銜接了tabBar所以必須把他關係到naviagtion才能改
        //隱藏自己自訂naviagtion的標題
        self.tabBarController?.navigationController?.isNavigationBarHidden = false;
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
