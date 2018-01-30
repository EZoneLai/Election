//
//  QRReaderViewController.swift
//  ElectionLoginDemo
//
//  Created by EZoneLai on 2017/3/8.
//  Copyright © 2017年 EZoneLai. All rights reserved.
//

import UIKit
//導入AVFoundation
import AVFoundation
//套用AVCaptureMetadataOutputObjectsDelegate
class QRReaderViewController: myViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    @IBOutlet weak var messageLabel:UILabel!
    
    var captureSession:AVCaptureSession?
    var videoPreviewLayer:AVCaptureVideoPreviewLayer?
    var qrCodeFrameView:UIView?
    
    //MARK: - 導入QR解碼
    let supportedBarCodes = [AVMetadataObjectTypeQRCode, AVMetadataObjectTypeCode128Code, AVMetadataObjectTypeCode39Code, AVMetadataObjectTypeCode93Code, AVMetadataObjectTypeUPCECode, AVMetadataObjectTypePDF417Code, AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeAztecCode]
    override func viewWillAppear(_ animated: Bool) {
        self.setTitleAndBackTitle(title: "", backTitle: "ㄑ上一頁", barColor: "entryColor")
        let titleView = UIImageView(frame: CGRect(x:0, y:0, width: 160, height: 40))
        titleView.contentMode = .scaleAspectFit
        titleView.image = self.appdelegate.logoImage
        self.navigationItem.titleView = titleView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //做一個appdelegate來代替UIApplication提高效能
        appdelegate = UIApplication.shared.delegate as! AppDelegate

        // 取得AVCaptureDevice類別的實體，初始化一個物件並提供AVMediaTypeVideo媒體型態參數
        //這是一個擷取影像資料的工具
        let captureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        
        do {
            // 用AVCaptureDevice來取得AVCaptureDeviceInput的實體
            let input = try AVCaptureDeviceInput(device: captureDevice)
            // 初始化captureSession物件
            captureSession = AVCaptureSession()
            // 設定輸入裝置
            captureSession?.addInput(input)
            //captureSession設定是AVCaptureMetadataOutput，用他來幫助擷取資料後輸出
            let captureMetadataOutput = AVCaptureMetadataOutput()
            captureSession?.addOutput(captureMetadataOutput)
            // 設定為主執行續
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            // Detect all the supported bar code
            captureMetadataOutput.metadataObjectTypes = supportedBarCodes
            
            // 初始化影像預覽層，加成videoPreview的子層
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            videoPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
            videoPreviewLayer?.frame = view.layer.bounds
            view.layer.addSublayer(videoPreviewLayer!)
            
            //MARK: -  開始讀取影像
            captureSession?.startRunning()
            
            // 在最上層顯示影像訊息
            view.bringSubview(toFront: messageLabel)
            
            //MARK: - 製作掃描框
            // 實體化 QR Code Frame 凸顯 QR code
            qrCodeFrameView = UIView()
            //改變邊框顏色
            if let qrCodeFrameView = qrCodeFrameView {
                qrCodeFrameView.layer.borderColor = UIColor.green.cgColor
                qrCodeFrameView.layer.borderWidth = 2
                view.addSubview(qrCodeFrameView)
                view.bringSubview(toFront: qrCodeFrameView)
            }
            
        } catch {
            // If any error occurs, simply print it out and don't continue any more.
            print(error)
            return
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK:- 將讀取QRCode的功能寫成func包在外部
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        
        // 檢查 metadataObjects array 不是空的
        if metadataObjects == nil || metadataObjects.count == 0 {
            qrCodeFrameView?.frame = CGRect.zero
            messageLabel.text = "No barcode/QR code is detected"
            return
        }
        // 取得 metadata 資料
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        // Here we use filter method to check if the type of metadataObj is supported
        // Instead of hardcoding the AVMetadataObjectTypeQRCode, we check if the type
        // can be found in the array of supported bar codes.
        if supportedBarCodes.contains(metadataObj.type) {
            //        if metadataObj.type == AVMetadataObjectTypeQRCode {
            // 如果發現相同資料，更新狀態，並設定邊界
            let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj)
            qrCodeFrameView?.frame = barCodeObject!.bounds
            ////////////////////////////
            //TODO: -- 錯誤處理預防空值
            //此處必須特別注意，刷了QRCode之後，確定了該用戶的upstream該值必須是Int!!! 
            ////////////////////////////
            if metadataObj.stringValue != nil {
                appdelegate.upstream = Int(metadataObj.stringValue)!
                print(appdelegate.upstream)
                launchApp(metadataObj.stringValue)
            }
        }
    }
    
    func launchApp(_ decodedURL: String) {
        
        if presentedViewController != nil {
            return
        }
        
        let alertPrompt = UIAlertController(title: "Open App", message: "You're going to open \(decodedURL)", preferredStyle: .actionSheet)
        let confirmAction = UIAlertAction(title: "Confirm", style: UIAlertActionStyle.default, handler: { (action) -> Void in
            
            if let url = URL(string: decodedURL) {
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.openURL(url)
                }
            }
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
        
        alertPrompt.addAction(confirmAction)
        alertPrompt.addAction(cancelAction)
        present(alertPrompt, animated: true, completion: nil)
        
    }
}

