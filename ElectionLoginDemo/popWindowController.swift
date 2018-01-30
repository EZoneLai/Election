//
//  popWindowController.swift
//  ElectionLoginDemo
//
//  Created by EZoneLai on 2017/2/23.
//  Copyright © 2017年 EZoneLai. All rights reserved.
//

import UIKit

/*
class popWindowController: UIAlertController {
    
    
    init(title: String?, message: String?, preferredStyle: UIAlertControllerStyle){
        super.init(title: title, message: message, preferredStyle: preferredStyle)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    convenience init(title:String, message:String, parent:UIViewController){
        self.init(title: title,message: message,preferredStyle: UIAlertControllerStyle.alert)
        //準備迸現視窗的按鈕，使他有退出鈕
        var okButton:UIAlertAction
        okButton = UIAlertAction(title: "OK",
                                 style: UIAlertActionStyle.default,
                                 handler: nil);
        //加上按鈕入popWinController
        self.addAction(okButton);
        //此時我們需要將畫面呈現在ViewController，但本calss只是一個Delegate，我們必須呼叫ViewController，故到上面去宣告一個ViewController來提供本calss轉換頁面呈現繃現視窗
        parent.present(popWinController, animated: true, completion: nil);
        
    }
    
    
}



//做一個alert或pop蹦現視窗
var popWinController:UIAlertController;
//呼叫UIAlertController的一個建構子來製作物件(title『標題文字』: "警告",message『訊息文字』: "你輸入了一個限制字元",preferredStyle『迸現風格（他是一種preferredStyle列舉，此先使用alert風格）』: UIAlertControllerStyle.alert);
popWinController = UIAlertController(title: "警告",
                                     message: "你輸入了一個限制字元",
                                     preferredStyle: UIAlertControllerStyle.alert);
//準備迸現視窗的按鈕，使他有退出鈕
var okButton:UIAlertAction
okButton = UIAlertAction(title: "OK",
                         style: UIAlertActionStyle.default,
                         handler: nil);
//加上按鈕入popWinController
popWinController.addAction(okButton);
//此時我們需要將畫面呈現在ViewController，但本calss只是一個Delegate，我們必須呼叫ViewController，故到上面去宣告一個ViewController來提供本calss轉換頁面呈現繃現視窗
myViewController.present(popWinController, animated: true, completion: nil);
 
 
 
 */
