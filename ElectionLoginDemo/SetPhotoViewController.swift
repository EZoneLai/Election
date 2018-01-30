//
//  SetPhotoViewController.swift
//  ElectionLoginDemo
//
//  Created by EZoneLai Lai on 2017/4/19.
//  Copyright © 2017年 EZoneLai. All rights reserved.
//

import UIKit
import AVFoundation



class SetPhotoViewController: myViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate ,URLSessionDelegate, Reaction{
    var photoType:String = "DEFAULT"
    var imagePicker:UIImagePickerController!
    var image:UIImage!//這個chooseRect在後面初始化成前一頁要上傳的UIImageView的大小
    var chooseRect:CGRect!
    var line:LineView!  //畫出要選取的大小，位置的一個透明UIView
    
    @IBOutlet weak var myImageView: UIImageView!
    
    //做一個URLSession而且必須是lazy的
//    lazy var uploadSession:URLSession = {
//        //let configuration = URLSessionConfiguration.ephemeral;
//        let session = URLSession(configuration: URLSessionConfiguration.default,
//                                 delegate: self,
//                                 delegateQueue: OperationQueue.main
//        );
//        return session
//    }();
    //let uploadSession = URLSession.shared;

    override func viewDidLoad() {
        super.viewDidLoad()
        //imagePicker.delegate = self
        
       
    }
    override func viewWillAppear(_ animated: Bool) {
        
        // MARK: - 套用myController的返回鍵設定
        //自訂的標題
        self.setTitleAndBackTitle(title: "", backTitle: "ㄑ上一頁", barColor: "mainColor")
        let titleView = UIImageView(frame: CGRect(x:0, y:0, width: 160, height: 40))
        titleView.contentMode = .scaleAspectFit
        titleView.image = self.appdelegate.logoImage
        self.navigationItem.titleView = titleView
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    // MARK: - 拍照相關
    @IBAction func takePhoto(_ sender: UIButton) {
        //check photoType
        print(photoType)
        // 先要判斷相機是否可用
        if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)) {
            // 建立一個ImagePickerController
            imagePicker = UIImagePickerController()
            // 設置 delegate
            imagePicker.delegate = self
            // 設定影像來源 這裡設定camera
            imagePicker.sourceType = .camera
            // 編輯啟用
            imagePicker.allowsEditing = true
            imagePicker.isEditing = true
            imagePicker.setEditing(true, animated: true)
            // 啟用前置鏡頭
            imagePicker.cameraDevice = UIImagePickerControllerCameraDevice.front
            // 關閉閃光燈
            imagePicker.cameraFlashMode = UIImagePickerControllerCameraFlashMode.off
            imagePicker.showsCameraControls = true
            // 啟用相機
            self.present(imagePicker, animated: true, completion: nil)
            
            chooseRect = CGRect(x: (self.view.frame.width - myImageView.frame.width)/2,
                                y: (self.view.frame.height - myImageView.frame.height)/2 - 36.40,
                                width: myImageView.frame.width,
                                height: myImageView.frame.height
            )
            line = LineView(drawArea: chooseRect,
                            frame: self.view.frame,
                            lineColor: UIColor.yellow
            )
            //把背景顏色透明，才能看到底下的照片
            line?.backgroundColor = UIColor.clear
            //把框線的畫面顯示
            //imagePicker.view.addSubview(line)
            //讓這個圖層觸碰效果關閉
            line?.isUserInteractionEnabled = false
            line?.tag = 999
            
            imagePicker.view.addSubview(line!)
            

        }else{
            noCameraAlert()
        }
    }
    // 判斷相機不可用函數
    func noCameraAlert() {
        let alertController = UIAlertController(title: "錯誤！", message: "沒有可用的相機", preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "確定", style: .default, handler: nil)
        alertController.addAction(okayAction)
        present(alertController, animated: true, completion: nil)
    }
 
    @IBAction func selectPhoto(_ sender: UIButton) {
        // 建立一個ImagePickerController
        imagePicker = UIImagePickerController()
        // popover
        var popover:UIPopoverPresentationController
        imagePicker.delegate = self
        // 編輯啟用
        imagePicker.allowsEditing = true
        imagePicker.isEditing = true
        imagePicker.setEditing(true, animated: true)
        
        // 設定影像來源 這裡設定photoLibrary
        imagePicker.sourceType = .photoLibrary
        //imagePicker.sourceType = .savedPhotosAlbum
        
        // 設定顯示模式
        imagePicker.modalPresentationStyle = UIModalPresentationStyle.popover
        popover = imagePicker.popoverPresentationController!
        popover.sourceView = sender
        // popover箭頭位置
        popover.sourceRect = sender.bounds
        popover.permittedArrowDirections = UIPopoverArrowDirection.any
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning?{
        
        print("to toVC")
        /////不想寫註解了！！！！！自己想！！！！
        guard toVC is UICollectionViewController else{
            /////把要裁切的CGRect做成線框加上照片畫面
            //在相機的話面上做一個透明圖層，上面有一個方框給使用者對
            //指定繪圖框的 位置 區域 框線顏色 填滿與否（預設不填滿）
            chooseRect = CGRect(x: (self.view.frame.width - myImageView.frame.width)/2,
                                y: (self.view.frame.height - myImageView.frame.height)/2,
                                width: myImageView.frame.width,
                                height: myImageView.frame.height
            )
            line = LineView(drawArea: chooseRect,
                            frame: self.view.frame,
                            lineColor: UIColor.yellow
            )
            //把背景顏色透明，才能看到底下的照片
            line?.backgroundColor = UIColor.clear
            //把框線的畫面顯示
            //imagePicker.view.addSubview(line)
            //讓這個圖層觸碰效果關閉
            line?.isUserInteractionEnabled = false
            line?.tag = 999
            
            imagePicker.view.addSubview(line!)
            
            if toVC.title != nil{
                if line != nil{
                    line.removeFromSuperview()
                }
                
            }
            
            
            return nil
        }
        
        if line != nil{
            line.removeFromSuperview()
        }
        
        
        //print("fromVC is \(fromVC.title) toVC is \(toVC.title)")
        
        
        return nil
    }
    
    //MARK:- UIImagePickerControllerDelegate
    //取得照片
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print("didFinishPickingMediaWithInfo")
        let screen_snap = self.captureScreen(view: picker.view)
        print("螢幕寬\(self.view.frame.width)")
        print("螢幕高\(self.view.frame.height)")
        print("=========")
        print("截圖寬\(screen_snap?.size.width ?? 78)")
        print("截圖高\(screen_snap?.size.height ?? 78)")
        print("=========")
        print("from_image_x:\(chooseRect.origin.x)  from_image_y:\(chooseRect.origin.y)")
        print("from_image_width:\(chooseRect.size.width)  from_image_height:\(chooseRect.size.height)")
        //let imageRef: CGImage = contextImage.cgImage!.cropping(to: cropRect)!
        //let image: UIImage = UIImage(cgImage: imageRef)
        
        let image: UIImage = self.cropToBounds(
            image: screen_snap!,
            //x: chooseRect.origin.x * 3 + 1,
            x: chooseRect.origin.x * (screen_snap?.scale)! + 1,
            //y: chooseRect.origin.y * 3 + 1,
            y: chooseRect.origin.y * (screen_snap?.scale)! + 1,
            //width:chooseRect.width*3 - 2 ,
            width:chooseRect.width*(screen_snap?.scale)! - 2 ,
            //height:chooseRect.height*3 - 2
            height:chooseRect.height*(screen_snap?.scale)! - 2
        )
        
        print("=========")
        print(screen_snap?.scale ?? 777888)
        print(image.scale)
        
        myImageView.image = image
        //myImageView.frame = self.view.frame
        //myImageView.contentMode = .scaleAspectFit
        self.appdelegate.generic.default_head = myImageView.image!
        // 將照片存起來
        let default_head_path:String = NSHomeDirectory() + "/Documents/anonymous.jpg"
        print("存取照片的位置在...\(default_head_path)")
        //MARK:- 此處自動幫使用者將照片上傳至資料庫中
        
        
        //TODO： 將得到的帳密上傳去server確認
        //用post 傳資料
        DispatchQueue.main.async {
            /*
            //TODO: 以後要做加密
            let key_data:[String] = [
                "account",
                "password",
                "setAphoto"
            ]
            
            let val_data:[String] = [
                "\(self.appdelegate.account)",
                "\(self.appdelegate.password)",
                "\(self.myImageView)"
            ]
            */
            
            //測試
            var query_string = ""
            query_string = "account=\(self.appdelegate.account)&password=\(self.appdelegate.password)&photoType=\(self.photoType)"
            //TODO: 要依照上面得到的photoType來判斷該上傳哪？並且該存在資料庫哪個欄位！
            let server_url_string = "http://\(self.appdelegate.server_ip)/URLRequest.php?" + query_string
            //print("上傳到mySQL\(server_url_string)")
            let cloud:my_cloud = my_cloud(server_url: server_url_string, type: TYPE.IMAGE)
            cloud.delegator = self
            //cloud.post_excute_data2(variable_name: key_data, datas: val_data)
            cloud.uploadImage(image: self.myImageView.image!, format: .JPEG)
        }
        
        
        
        
        /*
         //先前用的方法，等新方法完成再刪除
        var query_string = ""
        query_string = "account=\(appdelegate.account)&password=\(appdelegate.password)"
        let server_url = self.appdelegate.server_ip
        //TODO: 要依照上面得到的photoType來判斷該上傳哪？並且該存在資料庫哪個欄位！
        let server_url_string = "http://\(server_url)/URLRequest.php?" + query_string
        let url:NSURL = NSURL(string:server_url_string)!
        var request: URLRequest = URLRequest(url: url as URL)
        request.httpMethod = "POST"
        
        let session:URLSession = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: OperationQueue.main)
        //調整和壓縮照片的尺寸
        //let image:UIImage! = self.CameraView.image?.ResizeÜIImage(width: resizeWidth, height: resizeHeight)
        let uploadImage:UIImage! = self.myImageView.image
        //把照片轉成NSData（這是傳輸的需要）
        let file:Data = UIImageJPEGRepresentation(uploadImage, 0.994376)!
        //let file: NSData = UIImagePNGRepresentation(image)! as NSData
        
        //使用上傳uploadTask來執行上傳的session
        let task:URLSessionUploadTask = session.uploadTask(with: request, from: file as Data)
        
        //開始上傳
        task.resume()
        //完成上傳
 */
        picker.dismiss(animated:true, completion: nil)
    }
    
    //my_cloud的各種函數
    
    func notifyString(text:String){
        
    }
    func notifyImage(image:UIImage){
        
    }
    func notifyByte(data:Data){
        
    }
    func progressReport(persent:Double){
        
    }
    func notifyError(error:String){
        print("ERROR is \(error)")
        
        var popWinController:UIAlertController;
        
        popWinController = UIAlertController(title: "注意！",
                                             message: "未能成功上傳\n網路連線有誤",
                                             preferredStyle: UIAlertControllerStyle.alert);
        
        var okButton:UIAlertAction
        okButton = UIAlertAction(title: "OK",
                                 style: UIAlertActionStyle.default,
                                 handler:{
                                    finish
                                    in
                                    self.navigationController?.popViewController(animated: true)
        }
            
        );
        
        popWinController.addAction(okButton);
        
        self.present(popWinController, animated: true, completion: nil);
        
        print("網路出現問題")
        print(error)
    }
    func notifyExcuteResult(result:String){
        print("SERVER reply \(result)")
        let result = result.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if (result == "Record inserted successfully"){
            print("新增候選人頭像照片成功")
        }else if (result == "Record updated successfully"){
            print("新增個人頭像照片成功")
        }else{
            print("新增照片失敗\(result)")
        }
    }
    
    //MARK:- TOOL for handling
    
    /////裁切函數
    func cropToBounds(image: UIImage, x: CGFloat, y: CGFloat, width:CGFloat, height:CGFloat) -> UIImage {
        //let contextImage: UIImage = UIImage(cgImage: image.cgImage!)
        
        let contextSize: CGSize = image.size
        print(contextSize)
        let posX: CGFloat = x
        print(posX)
        let posY: CGFloat = y
        
        // See what size is longer and create the center off of that
        
        
        let rect: CGRect = CGRect(x: posX, y: posY, width: width, height: height)
        print(rect)
        // Create bitmap image from context using the rect
        let imageRef: CGImage = image.cgImage!.cropping(to: rect)!
        
        // Create a new image based on the imageRef and rotate back to the original orientation
        let image: UIImage = UIImage(cgImage: imageRef, scale: image.scale, orientation: image.imageOrientation)
        
        return image
    }
    
    /////擷取某個UIView的畫面
    func captureScreen(view:UIView) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, UIScreen.main.scale)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    //取消按鈕
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // 關閉相機
        self.dismiss(animated: true, completion: nil)
    }
    
}





//擴展一個處理字串的函數
extension NSMutableData {
    func appendString(_ string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: false)
        append(data!)
    }
}
//擴展切函數
//extension UIImage {
//    func crop(rect: CGRect) -> UIImage {
//        var rect = rect
//        rect.origin.x*=self.scale
//        rect.origin.y*=self.scale
//        rect.size.width*=self.scale
//        rect.size.height*=self.scale
//        
//        let imageRef = self.cgImage!.cropping(to: rect)
//        let image = UIImage(cgImage: imageRef!, scale: self.scale, orientation: self.imageOrientation)
//        return image
//    }
//}


