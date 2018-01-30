//
//  MCListViewController.swift
//  ElectionLoginDemo
//
//  Created by EZoneLai Lai on 2017/5/16.
//  Copyright © 2017年 EZoneLai. All rights reserved.
//

import UIKit

class SupportListViewController: myViewController, UITableViewDelegate, UITableViewDataSource {
    //  MARK: - 宣告基礎變數常數
    var ListName:String = "請選擇"
    var navigationTitle:String = "請選擇"
    var aType:String = "DEFAULT"
    var ListData:[String] = []
    
    var ListDictionary = Dictionary<String, Any>()
    
    @IBOutlet weak var desktopImage: UIImageView!
    
    
    @IBOutlet weak var MCListTableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        //先檢查aType
        switch aType {
        case "MC":
            ListName = "請選擇議員"
            navigationTitle = "選擇議員"
            break
        case "HD":
            ListName = "請選擇里長"
            navigationTitle = "選擇里長"
            break
        case "ER":
            ListName = "請選擇民代"
            navigationTitle = "選擇民代"
            break
        case "ML":
            ListName = "請選擇立委"
            navigationTitle = "選擇立委"
            break
        default:
            aType = "MC"
            //print("no pass in")
            break
        }

        // MARK: - 套用myController的返回鍵設定
        //自訂的標題
        self.setTitleAndBackTitle(title: navigationTitle, backTitle: "ㄑ上一頁", barColor: "mainColor")
        //套用預設底圖
        if (appdelegate.desktopWallpaperImage != nil){
            desktopImage.image = appdelegate.desktopWallpaperImage
        }else{
            desktopImage.image = UIImage(named: "song510x732")
        }
    }

    //先到server將議員的列表撈出
    override func viewDidAppear(_ animated: Bool) {
        
        let already_path:String = NSHomeDirectory() + "/Documents/already.data"
        let manager:FileManager = FileManager.default
        //檢查登入紀錄檔already.data，如果不存在
        if !manager.fileExists(atPath: already_path){
            print("沒有檔案")
        }else{
            ///如果already.data存在，走已有帳號登入流程
            print("已有檔案")
            //上傳到Server Check
            let check_sutype_url = URL(string: "http://\(appdelegate.server_ip)/check_sutype.php?aType=\(aType)")!
            print("http://\(appdelegate.server_ip)/check_sutype.php?aType=\(aType)")
            var results:String!
            do {
                results = try String(contentsOf: check_sutype_url, encoding: .utf8)
                //拿到伺服器的回應
                //print("伺服器回應：\(results)")
                
            } catch  {
                print("Fail connect to server")
                //TODO: 寫錯誤處理 彈出視窗
                
                print(error)
                return
            }
            //MARK:- 把伺服器回應的東西(JSON)做成Dictionary，存給MCListData
            //let datas = results.components(separatedBy: "\\\\")
            //let datas = results
            //print(results)
            let datas = results.data(using: .utf8)
            do{
                let jsonObj =  try JSONSerialization.jsonObject(with: datas!, options: .mutableContainers) as! [String:Any]
                print(jsonObj)
                
                ListData = (jsonObj as NSDictionary).allKeys as! [String]
                //測試弄成要的陣列
                ListDictionary = jsonObj as Dictionary<String,Any>
                
                MCListTableView.reloadData()
            } catch{
                print("Fail connect to JSON")
                //TODO: 寫錯誤處理 彈出視窗
                
                print(error)
                return
            }
            print(ListDictionary)
            
        }
    }
    
    //  MARK: - 加入UITableViewDataSource
    //UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return ListData.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath);
        cell.textLabel?.textColor = UIColor.white
        cell.backgroundColor = UIColor.clear
        cell.textLabel?.textAlignment = .left
        cell.detailTextLabel?.textAlignment = .left
        cell.textLabel?.text = ListData[indexPath.row]
        
        return cell;
    }
    
    func numberOfSections(in tableView: UITableView) -> Int{
        return 1;
    }
    // MARK: - 加入UITableViewDelegate
    //UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        //TODO:將選的字所對定的sn_id傳回
        /////只要判定點到哪一名字
        let select:String = (ListData[indexPath.row])
        ListName = select
        print("點到哪個\(select)")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: - 調整頁面下推
        //self.definesPresentationContext = true
        edgesForExtendedLayout = [];
        
        // MARK: -  宣告UITableViewDelegate
        MCListTableView.delegate = self;
        MCListTableView.dataSource = self;
        MCListTableView.rowHeight = 60;
        
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - 設定確定按鈕
    @IBAction func checkBackButton(_ sender: UIButton) {

        //MARK: - 把選擇的議員，回去改掉按鈕上的字
        if ListName != "請選擇"{
            //TODO: 必須把這個值存到SERVER
            switch aType {
            case "MC":
                let MCNmber = Int(ListDictionary[ListName] as! String)!
                appdelegate.sumc = MCNmber
                print("選的是:\(ListName)")
                print(MCNmber)
                break
            case "HD":
                //改掉按鈕的字
                let HDButtonName = ListName + " 里長"
                
                let HDNmber = Int(ListDictionary[ListName] as! String)!
                appdelegate.suhd = HDNmber
                print("選的是:\(ListName)")
                print(HDNmber)
                break
            case "ER":
                //改掉按鈕的字
                let ERButtonName = ListName + " 民代"
                
                let ERNmber = Int(ListDictionary[ListName] as! String)!
                appdelegate.suer = ERNmber
                print("選的是:\(ListName)")
                print(ERNmber)
                break
            case "ML":
                
                let MLNmber = Int(ListDictionary[ListName] as! String)!
                appdelegate.suml = MLNmber
                print("選的是:\(ListName)")
                print(MLNmber)
                break
            default:
                break
            }

            //用POP的方式，跳回最前頁
            self.navigationController!.popToViewController(self.appdelegate.markController, animated: true)
        }else{
            //TODO: 在此給一個彈出視窗，告知使用者該輸入的資料不完整。
            //做一個alert或pop蹦現視窗
            var popWinController:UIAlertController;
            
            //呼叫UIAlertController的一個建構子來製作物件(title『標題文字』: "警告",message『訊息文字』: "你輸入了一個限制字元",preferredStyle『迸現風格（他是一種preferredStyle列舉，此先使用alert風格）』: UIAlertControllerStyle.alert);
            popWinController = UIAlertController(title: "注意",
                                                 message: "請選擇支持者，\n或按ㄑ上一頁",
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
            print(ListName);
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

