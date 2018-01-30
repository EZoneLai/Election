//
//  Supported.swift
//  ElectionLoginDemo
//
//  Created by EZoneLai Lai on 2017/5/16.
//  Copyright © 2017年 EZoneLai. All rights reserved.
//

import UIKit

class Generic: NSObject {
    
    ////通用頁面
    //選情資訊
    var informationWeb:String!
    var information_web:String{
        get{
            return self.informationWeb
        }
        set(value){
            self.informationWeb = value
        }
    }
    
    //發送通知
    var pushNoticeWeb:String!
    var push_notice_web:String{
        get{
            return self.pushNoticeWeb
        }
        set(value){
            self.pushNoticeWeb = value
        }
    }
    //話術輯
    var manuscriptWeb:String!
    var manuscript_web:String{
        get{
            return self.manuscriptWeb
        }
        set(value){
            self.manuscriptWeb = value
        }
    }
    
    
    ////專屬頁面
    //公司首頁
    var myHomepageWeb:String!
    var my_homepage_web:String{
        get{
            return self.myHomepageWeb
        }
        set(value){
            self.myHomepageWeb = value
        }
    }
    //福利
    var annoucementWeb:String!
    var annoucement_web:String{
        get{
            return self.annoucementWeb
        }
        set(value){
            self.annoucementWeb = value
        }
    }
    //政策
    var policyWeb:String!
    var policy_web:String{
        get{
            return self.policyWeb
        }
        set(value){
            self.policyWeb = value
        }
    }
    //關係圖示
    var relationD3jsWeb:String!
    var relation_d3js_web:String{
        get{
            return self.relationD3jsWeb
        }
        set(value){
            self.relationD3jsWeb = value
        }
    }
    //緊急事件處理
    var emergencyWeb:String!
    var emergency_web:String{
        get{
            return self.emergencyWeb
        }
        set(value){
            self.emergencyWeb = value
        }
    }
    //服務團隊
    var aidesWeb:String!
    var aides_web:String{
        get{
            return self.aidesWeb
        }
        set(value){
            self.aidesWeb = value
        }
    }
    //選民留言板
    var publicOpinionWeb:String!
    var public_opinion_web:String{
        get{
            return self.publicOpinionWeb
        }
        set(value){
            self.publicOpinionWeb = value
        }
    }
    //通訊錄
    var contactWeb:String!
    var contact_web:String{
        get{
            return self.contactWeb
        }
        set(value){
            self.contactWeb = value
        }
    }
    //初始大頭照
    var defaultHead:UIImage!
    var default_head:UIImage{
        get{
            return self.defaultHead
        }
        set(value){
            self.defaultHead = value
        }
    }
    
    //初始大頭照大小
    var defaultHeadSize:CGSize!
    var default_head_size:CGSize{
        get{
            return self.defaultHeadSize
        }
        set(value){
            self.defaultHeadSize = value
        }
    }
    
    
    override init() {
        print("generic物件建立")
        super.init()
        //檢查預設的公版紀錄
        let file_manager = FileManager.default
        let generic_sandbox_path:String = NSHomeDirectory() + "/Documents/generic_data.json"
        
        let bundle_generic_path = Bundle.main.path(forResource: "generic_data", ofType: "json")!
        print("我是存到沙箱的路徑\(generic_sandbox_path)")
        if !file_manager.fileExists(atPath: generic_sandbox_path){
            //如果手機內沒有預設的公版紀錄，建立一份給他
            do{
                
                
                
                try file_manager.copyItem(atPath: bundle_generic_path, toPath:generic_sandbox_path)
                
            }catch{
                ////報錯
                print("=================write fail=========\(error)")
            }
            
        }
        
        //"abc".write(other: String)
        if AppDelegate.flag.UNDER_DEVELOPING{
            //如果手機內沒有預設的公版紀錄，建立一份給他
            do{
                //TODO: 要改成重寫一份
                
                
                try file_manager.copyItem(atPath: bundle_generic_path, toPath:generic_sandbox_path)
                
            }catch{
                ////報錯
                print("=================write fail=========\(error)")
            }
        }
        //讀出該紀錄檔
        let data = try! NSData(contentsOfFile: generic_sandbox_path) as Data
        let generic_data = try! JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableLeaves)
        //print("AaAAAAAAAAAA \((generic_data as! Dictionary)["informationWeb"]! as String)")
        //將紀錄檔內的設定，指定給預設的webSide
        self.informationWeb = (generic_data as! Dictionary)["information_web"]! as String
        //print(self.informationWeb)
        self.pushNoticeWeb = (generic_data as! Dictionary)["push_notice_web"]! as String
        self.manuscriptWeb = (generic_data as! Dictionary)["manuscript_web"]! as String
        self.myHomepageWeb = (generic_data as! Dictionary)["my_homepage_web"]! as String
        self.annoucementWeb = (generic_data as! Dictionary)["annoucement_web"]! as String
        self.policyWeb = (generic_data as! Dictionary)["policy_web"]! as String
        self.relationD3jsWeb = (generic_data as! Dictionary)["relation_d3js_web"]! as String
        self.emergencyWeb = (generic_data as! Dictionary)["emergency_web"]! as String
        self.aidesWeb = (generic_data as! Dictionary)["aides_web"]! as String
        self.publicOpinionWeb = (generic_data as! Dictionary)["public_opinion_web"]! as String
        self.contactWeb = (generic_data as! Dictionary)["contact_web"]! as String
        
        //將紀錄檔內的設定，指定給預設的頭像照片及其大小
        //self.defaultHead = (generic_data as! Dictionary)["defaultHead"]! as UIImage
        //self.defaultHeadSize = (generic_data as! Dictionary)["defaultHeadSize"]! as CGSize
    }
    
    
    //////////
    //測試位置
    var test_side:String = "http://twin.taipei/app_test/upload"
    var testSide:String{
        get{
            return self.test_side
        }
        set(value){
            self.test_side = value
        }
    }
    
    
    
}



