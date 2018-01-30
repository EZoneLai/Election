//
//  TestViewController.swift
//  twin.taipei.Election
//
//  Created by EZoneLai Lai on 2017/9/27.
//  Copyright © 2017年 EZoneLai. All rights reserved.
//

import UIKit
import MessageUI

class TestViewController: UIViewController , MFMessageComposeViewControllerDelegate{
    

    var x:[[AnyHashable:Any]]!
    @IBAction func msgBut(_ sender: Any) {
        var messageVC = MFMessageComposeViewController()
        //產生一組驗證碼
        messageVC.body = "Enter a message";
        //要打的電話號碼
        messageVC.recipients = ["0921978006"]
        messageVC.messageComposeDelegate = self;
        
        messageVC.addAttachmentData("secrect".data(using: .utf8)!, typeIdentifier: "secrect", filename: "secrect.txt")
        x  = messageVC.attachments
        
        self.present(messageVC, animated: false, completion: nil)
        
        
        
    }
    
   
    
    
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        
        print(x)
        
        switch (result) {
        case MessageComposeResult.cancelled:
            print("Message was cancelled")
            self.dismiss(animated: true, completion: nil)
        case MessageComposeResult.failed:
            print("Message failed")
            self.dismiss(animated: true, completion: nil)
        case MessageComposeResult.sent:
            print("Message was sent")
        
            self.dismiss(animated: true, completion: nil)
            
        default:
            break;
        }
    }
 
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
 

}
