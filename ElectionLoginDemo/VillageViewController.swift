//
//  VillageViewController.swift
//  ElectionLoginDemo
//
//  Created by EZoneLai on 2017/2/15.
//  Copyright © 2017年 EZoneLai. All rights reserved.
//

import UIKit

class VillageViewController: myViewController, UITableViewDelegate, UITableViewDataSource {
    //  MARK: - 宣告基礎變數常數
    var villageName:String = "請選擇地區"
    @IBOutlet weak var villageTableView: UITableView!
    var villageData:[String] = []
    
 
    //  MARK: - 加入UITableViewDataSource
    //UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return villageData.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "villageCell", for: indexPath);
        cell.textLabel?.textColor = UIColor.white
        cell.backgroundColor = UIColor.clear
        cell.textLabel?.textAlignment = .left
        cell.detailTextLabel?.textAlignment = .left
        cell.textLabel?.text = villageData[indexPath.row]
        
        return cell;
    }
    
    func numberOfSections(in tableView: UITableView) -> Int{
        return 1;
    }
    // MARK: - 加入UITableViewDelegate
    //UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        //將選的字傳回
        let selectVillage:String = (villageData[indexPath.row])
        villageName = selectVillage
        //delegate?.sendVillageName(villageName: villageName)
        //print("點選了：\(selectVillage)")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: - 調整頁面下推
        //self.definesPresentationContext = true
        //edgesForExtendedLayout = [];
        
        // MARK: -  宣告UITableViewDelegate
        villageTableView.delegate = self;
        villageTableView.dataSource = self;
        villageTableView.rowHeight = 60;
        
        
        //print(Bundle.main.path(forResource: "桃園區", ofType: "data")!)
        
        //print("file://" + Bundle.main.path(forResource: "桃園區", ofType: "data")!)
        
        //let url = URL(string: "file://" + Bundle.main.path(forResource: "original", ofType: "data")!)
        
        //print("xxx--->\(url)")
        
        do{
            
            /*let data = try String(
                contentsOf: URL(string: "file://" + Bundle.main.path(forResource: "桃園區", ofType: "data")!)!, encoding: String.Encoding.utf8)
            */
            let resourceString = self.appdelegate.district
            //print(self.appdelegate.district)
            let temp = try String(contentsOfFile: Bundle.main.path(forResource: resourceString, ofType: "data")!)
            
            villageData = temp.components(separatedBy: ",\n")
            
            //var i:Int = 0
//            for var t:String in villageData{
//               let from_index = t.index(t.startIndex, offsetBy: 0)
//               t = t.substring(from: from_index)
//               let to_index = t.index(t.startIndex, offsetBy: 2)
//               t = t.substring(to: to_index)
//                print(t)
//            }
            
            
            
            
            //print(villageData)
            //let lines = villageData.components(separatedBy: "\n")
            //print(lines)
        }catch{
            
        }
       
    }
    override func viewWillAppear(_ animated: Bool) {
        // MARK: - 套用myController的返回鍵設定
        //自訂的標題
        self.setTitleAndBackTitle(title: "選擇里", backTitle: "ㄑ上一頁", barColor: "entryColor")
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
    
    //MARK: - 設定確定按鈕
    @IBAction func checkBackButton(_ sender: UIButton) {
        
        //MARK: - 把選擇的里，回去改掉按鈕上的字
        if villageName != "請選擇地區"{
            ////將選的字傳回AppDelegate
            appdelegate.village = villageName
            appdelegate.address =
                appdelegate.city  + "::" +
                appdelegate.district  + "::" +
                appdelegate.village
            print("此使用者的位址：\(appdelegate.address)")
            let adress = appdelegate.city  + " " +
                appdelegate.district  + " " +
                appdelegate.village
            appdelegate.adressTitle = adress
            
            //用POP的方式，跳回最前頁
            self.navigationController!.popToViewController(appdelegate.markController, animated: true)
        }else{
            //TODO: 在此給一個彈出視窗，告知使用者該輸入的資料不完整。
            //做一個alert或pop蹦現視窗
            var popWinController:UIAlertController;
            
            //呼叫UIAlertController的一個建構子來製作物件(title『標題文字』: "警告",message『訊息文字』: "你輸入了一個限制字元",preferredStyle『迸現風格（他是一種preferredStyle列舉，此先使用alert風格）』: UIAlertControllerStyle.alert);
            popWinController = UIAlertController(title: "注意",
                                                 message: "請選擇地區，\n來進行下一步",
                                                 preferredStyle: UIAlertControllerStyle.alert);
            //準備迸現視窗的按鈕，使他有退出鈕
            var okButton:UIAlertAction
            okButton = UIAlertAction(title: "OK",
                                     style: UIAlertActionStyle.default,
                                     handler: nil);
            //加上按鈕入popWinController
            popWinController.addAction(okButton);
            //此時我們需要將畫面呈現在ViewController，但本calss只是一個Delegate，我們必須呼叫ViewController，故到上面去宣告一個ViewController來提供本calss轉換頁面呈現繃現視窗
            self.present(popWinController, animated: true, completion: nil);
            print(villageName);
        }
        
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
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

