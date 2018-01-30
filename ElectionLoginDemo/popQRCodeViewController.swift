//
//  popQRCodeViewController.swift
//  ElectionLoginDemo
//
//  Created by EZoneLai on 2017/3/10.
//  Copyright © 2017年 EZoneLai. All rights reserved.
//

import UIKit
import CoreImage //Core Image 濾波器
class popQRCodeViewController: UIViewController {
    //做一個appdelegate他是AppDelegate
    var appdelegate:AppDelegate!
    
    @IBOutlet weak var imgQRCode: UIImageView!
    
    var qrcodeImage: CIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //做一個appdelegate來代替UIApplication提高效能
        appdelegate = UIApplication.shared.delegate as! AppDelegate
        //MARK:- 製作QRCode
        //先檢查qrcodeImage
        
        if qrcodeImage == nil //如果沒有qrcodeImage
        {   //再撿查guid
            if appdelegate.guid == "" //如果是空的就不做
            {
                //測試先給一個
                print("這是GUID\(appdelegate.guid)")
                return
            }
            //建立新的 CoreImage 濾波器（利用 CIQRCodeGenerator ）來指定一些參數。
            
            //String.Encoding 用 isoLatin1 也是可以
            let data = appdelegate.guid.data(using: String.Encoding.utf8, allowLossyConversion: false)
            
            let filter = CIFilter(name: "CIQRCodeGenerator")
            //inputMessage 這是要轉換成 QR Code 圖片的初始資料。事實上，此參數必須是 NSData 物件，所以請確定你所使用的字串或其他物件都已轉換成這種資料類型。
            filter?.setValue(data, forKey: "inputMessage")
            //inputCorrectionLevel：這裡表示有多少額外的錯誤更正資料要被附加到輸出的 QR Code 圖片中。其數值是 4 種字串之一： L 、 M 、 Q 、 H ，分別對應到不同的錯誤復原能力，依序為 7% 、 15% 、 25% 、 30% 。數值越大，輸出的 QR Code 圖片也就越大。
            filter!.setValue("H", forKey: "inputCorrectionLevel")
            
            qrcodeImage = filter!.outputImage
            
            displayQRCodeImage()
        }
        else {
            displayQRCodeImage()
            
        }
        // Do any additional setup after loading the view.
    }

    // MARK: Custom method implementation
    func displayQRCodeImage() {
        let scaleX = imgQRCode.frame.size.width / qrcodeImage.extent.size.width
        let scaleY = imgQRCode.frame.size.height / qrcodeImage.extent.size.height
        
        let transformedImage = qrcodeImage.applying(CGAffineTransform(scaleX: scaleX, y: scaleY))
        
        imgQRCode.image = UIImage(ciImage: transformedImage)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func finishPOPButton(_ sender: UIButton) {
        self.dismiss(animated: true)
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
