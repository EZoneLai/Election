//
//  SetUserImageViewController.swift
//  ElectionLoginDemo
//
//  Created by EZoneLai Lai on 2017/7/20.
//  Copyright © 2017年 EZoneLai. All rights reserved.
//

import UIKit
import AVFoundation


class SetUserImageViewController: myViewController,UIScrollViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate, URLSessionTaskDelegate, URLSessionDataDelegate, URLSessionDelegate {
    
    var imagePicker:UIImagePickerController!
    var image:UIImage!
    var chooseRect:CGRect!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var imageViewWidth: NSLayoutConstraint!
    @IBOutlet weak var imageViewHeight: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //imagePicker.delegate = self
        scrollView.delegate = self
        
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
            // 啟用相機
            self.present(imagePicker, animated: true, completion: nil)
            
            //在相機的話面上做一個透明圖層，上面有一個方框給使用者對
            //指定繪圖框的 位置 區域 框線顏色 填滿與否（預設不填滿）
            chooseRect = CGRect(x: self.view.frame.width * 0.5 - 130.0,
                                y: self.view.frame.height * 0.45 - 185.0,
                                width: 260.0,
                                height: 390.0)
            let line = LineView(drawArea: chooseRect,
                                frame: self.view.frame,
                                lineColor: UIColor.yellow
            )
            //把背景顏色透明，才能看到底下的照片
            line.backgroundColor = UIColor.clear
            //把框線的畫面顯示
            imagePicker.view.addSubview(line)
            //讓這個圖層觸碰效果關閉
            line.isUserInteractionEnabled = false
            
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
        imagePicker.delegate = self
        // 編輯啟用
        imagePicker.allowsEditing = true
        imagePicker.isEditing = true
        imagePicker.setEditing(true, animated: true)
        
        // 設定影像來源 這裡設定photoLibrary
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    
    //取得照片
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        // 把照片傳給原本的imageView，設定比例
        picker.showsCameraControls = true
        let chosenImage = info[UIImagePickerControllerEditedImage] as! UIImage
        //let cropImage = info[UIImagePickerControllerCropRect] as! UIImage
        //let changedImage = setImageToCrop(image: chosenImage)
        myImageView.image = chosenImage
        self.appdelegate.generic.default_head = chosenImage
        //MARK:- 此處自動幫使用者將照片上傳至資料庫中
        //指定URL並執行該PHP
        var query_string = ""
        query_string = "account=\(appdelegate.account)&password=\(appdelegate.password)"
        let server_url_string = "http://172.20.10.7/URLRequest.php?" + query_string
        let url:NSURL = NSURL(string:server_url_string)!
        var request: URLRequest = URLRequest(url: url as URL)
        request.httpMethod = "POST"
        //
        let session:URLSession = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: OperationQueue.main)
        //調整和壓縮照片的尺寸
        //let image:UIImage! = self.CameraView.image?.ResizeÜIImage(width: resizeWidth, height: resizeHeight)
        let image:UIImage! = self.myImageView.image
        //把照片轉成NSData（這是傳輸的需要）
        let file:Data = UIImageJPEGRepresentation(image, 0.994376)!
        //let file: NSData = UIImagePNGRepresentation(image)! as NSData
        
        
        //使用上傳uploadTask來執行上傳的session
        let task:URLSessionUploadTask = session.uploadTask(with: request, from: file as Data)
        /*
        let task:URLSessionUploadTask = session.uploadTask(with: request, from: file as Data) {
            (data:Data?, response:URLResponse?, error:Error?) -> Void in
            //上传完毕后
            guard let data = data else {
                print("request failed \(String(describing: error))")
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data) as? [String: String], let name = json["name"] {
                    print("name = \(name)")   // if everything is good, you'll see "William"
                }
            } catch let parseError {
                print("parsing error: \(parseError)")
                let responseString = String(data: data, encoding: .utf8)
                print("raw response: \(String(describing: responseString))")
            }
            
            
//            if error != nil{
//                print(error ?? "失敗")
//            }
//            print("response = \(String(describing: response))")
            
            //let responseString = String(data: data, encoding: String.Encoding.utf8)
            //print("responseString = \(responseString)")
        }*/
        //開始上傳
        task.resume()
        //完成上傳
        // 關閉相機
        self.dismiss(animated:true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // 關閉相機
        self.dismiss(animated: true, completion: nil)
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return myImageView
    }
    
    func setImageToCrop(image:UIImage){
        myImageView.image = image
        imageViewWidth.constant = image.size.width
        imageViewHeight.constant = image.size.height
        let scaleHeight = scrollView.frame.size.width/image.size.width
        let scaleWidth = scrollView.frame.size.height/image.size.height
        scrollView.minimumZoomScale = max(scaleWidth, scaleHeight)
        scrollView.zoomScale = max(scaleWidth, scaleHeight)
    }
    
}

