//
//  my_cloud.swift
//
//
//  Created by EZoneLai Lai on 2017/8/12.
//  Copyright © 2017年 EZoneLai Lai. All rights reserved.
//

import UIKit
import SystemConfiguration

enum TYPE{
    case IMAGE
    case TEXT
    case BINARY
}


enum IMAGE_FORMAT{
    case JPEG
    case PNG
}

protocol Reaction {
    func notifyString(text:String)
    func notifyImage(image:UIImage)
    func notifyByte(data:Data)
    func progressReport(persent:Double)
    func notifyError(error:String)
    func notifyExcuteResult(result:String);
}

class my_cloud: NSObject, URLSessionTaskDelegate, URLSessionDataDelegate, URLSessionDelegate, URLSessionDownloadDelegate {
    
    var delegator:Reaction!
    
    var download_data:Data = Data()
    var download_string:String!
    var download_image:UIImage!
    private var operation_type:TYPE!
    private var server_url:String = ""
    
    
    init(server_url:String, type:TYPE)
    {
        self.server_url = server_url;
        self.operation_type = type
    }
    
    func upload(uploadData:Data){
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 15
        let session:URLSession = URLSession(
            configuration: configuration,
            delegate: self,
            delegateQueue: OperationQueue()
        )
        
        let url:URL = URL(string: self.server_url)!
        var request: URLRequest = URLRequest(url:url)
        request.httpMethod = "POST"
        let task:URLSessionUploadTask = session.uploadTask(with: request, from: uploadData)
        /*
         let task:URLSessionUploadTask = session.uploadTask(
         with: request,
         from: file,
         completionHandler:
         {
         (data, response,error)
         in
         print("伺服器回應:\(response)")
         
         if let err = error{
         print("錯誤是:\(err)")
         }else{
         print("伺服器data:\(data)")
         }
         }
         
         )
         */
        task.resume()
        
    }
    
    //// no return value
    func post_excute_data(variable_name:[String], datas:[String]){
        
        let session:URLSession = URLSession(
            configuration: URLSessionConfiguration.default,
            delegate: self,
            delegateQueue: OperationQueue()
        )
        
        let url:URL = URL(string: self.server_url)!
        var request: URLRequest = URLRequest(url:url)
        request.httpMethod = "POST"
        
        var paramaters:String = ""
        var first:Bool = true
        var index:Int = 0
        for v_name in variable_name{
            
            if first{
                first = false
            }else{
                paramaters = paramaters + "&"
            }
            
            paramaters = paramaters + v_name
            paramaters = paramaters + "="
            paramaters = paramaters + datas[index].addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
            index = index + 1
        }
        print(paramaters)
        
        let file: Data = paramaters.data(using: .utf8)!
        let task:URLSessionUploadTask = session.uploadTask(with: request, from: file )
        /*
         let task:URLSessionUploadTask = session.uploadTask(
         with: request,
         from: file,
         completionHandler:
         {
         (data, response,error)
         in
         print("伺服器回應:\(response)")
         
         if let err = error{
         print("錯誤是:\(err)")
         }else{
         print("伺服器data:\(data)")
         }
         }
         
         )
         */
        task.resume()
        
    }
    
    // with return value
    func post_excute_data2(variable_name:[String], datas:[String]){
        
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 10
        let session:URLSession = URLSession(
            configuration: configuration,
            delegate: self,
            delegateQueue: OperationQueue()
        )
        
        let url:URL = URL(string: self.server_url)!
        var request: URLRequest = URLRequest(url:url)
        request.httpMethod = "POST"
        
        var paramaters:String = ""
        var first:Bool = true
        var index:Int = 0
        for v_name in variable_name{
            
            if first{
                first = false
            }else{
                paramaters = paramaters + "&"
            }
            
            paramaters = paramaters + v_name
            paramaters = paramaters + "="
            paramaters = paramaters + datas[index].addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
            index = index + 1
        }
        print(paramaters)
        
        request.httpBody = paramaters.data(using: .utf8)
        let task:URLSessionTask = session.dataTask(with: request, completionHandler:
        {
            (data,response,error)
            in
            if let err = error{
                print("ERROR")
                OperationQueue.main.addOperation{
                    self.delegator.notifyError(error: err.localizedDescription)
                }
                
                
            }else{
                print("RESULT")
                OperationQueue.main.addOperation{
                    self.delegator.notifyExcuteResult(result: String(data: data!, encoding: .utf8)!)
                }
                
            }
        }
        )
        
        task.resume()
        
    }

    
    func download(){
       
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 15
        let session:URLSession = URLSession(
            configuration: configuration,
            delegate: self,
            delegateQueue: OperationQueue()
        )
        
        let url:URL = URL(string: self.server_url)!
        
        let task:URLSessionDownloadTask = session.downloadTask(with: URLRequest(url: url))
        task.resume()
        let data_task:URLSessionDataTask = session.dataTask(with: URLRequest(url: url))
        data_task.resume()
        
    }
    
    func uploadString(text:String){
        let data = text.data(using: .utf8)
        self.upload(uploadData: data!)
    }
    
    func uploadImage(image:UIImage, format:IMAGE_FORMAT, rate:CGFloat = 1.0){
        
        var data:Data
        switch(format){
        case .JPEG:
            data = UIImageJPEGRepresentation(image, rate)!
        case .PNG:
            data = UIImagePNGRepresentation(image)!
        }
        
        print("Data byte ----> \(data.count)")
        self.upload(uploadData: data)
        
    }
    
    //MARK:-  URLSessionDelegate 函數
    //urlSession(_:didBecomeInvalidWithError:)
    //Tells the URL session that the session has been invalidated.
    func urlSession(_ session: URLSession, didBecomeInvalidWithError error: Error?) {
        print("didBecomeInvalidWithError")
        if let e = error {
            OperationQueue.main.addOperation{
                self.delegator.notifyError(error: e.localizedDescription)
            }
            
        }
    }
    
    //urlSession(_:didReceive:completionHandler:)
    //Requests credentials from the delegate in response to a session-level authentication request from the remote server.
    
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        //print("xxxxxyyyyy")
        download_data.append(data)
    }
    
    
    //MARK:- URLSessionTaskDelegate
    //urlSession(_:task:didReceive:completionHandler:)
    //Requests credentials from the delegate in response to an authentication request from the remote server.
    func urlSession(_ session: URLSession, task: URLSessionTask, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void){
        //print("didReceive challenge")
    }
    
    //urlSession(_:task:didSendBodyData:totalBytesSent:totalBytesExpectedToSend:)
    //Periodically informs the delegate of the progress of sending body content to the server.
    func urlSession(_ session: URLSession, task: URLSessionTask, didSendBodyData bytesSent: Int64, totalBytesSent: Int64, totalBytesExpectedToSend: Int64){
        //print("  全部有----> \(totalBytesExpectedToSend)  送出了----> \(totalBytesSent)")

        
        OperationQueue.main.addOperation {
            self.delegator.progressReport(persent: Double(totalBytesSent)/Double(totalBytesExpectedToSend))
        }
        
        if totalBytesSent == totalBytesExpectedToSend{
            print("UPLOAD COMPLETED!!!")
            OperationQueue.main.addOperation {
                self.delegator.notifyString(text: "上傳OK")
            }
        }
    }
    
    //urlSession(_:task:needNewBodyStream:)
    //Tells the delegate when a task requires a new request body stream to send to the remote server.
    func urlSession(_ session: URLSession, task: URLSessionTask, needNewBodyStream completionHandler: @escaping (InputStream?) -> Void){
        print("needNewBodyStream")
    }
    
    //urlSession(_:task:willPerformHTTPRedirection:newRequest:completionHandler:)
    //Tells the delegate that the remote server requested an HTTP redirect.
    func urlSession(_ session: URLSession, task: URLSessionTask, willPerformHTTPRedirection response: HTTPURLResponse, newRequest request: URLRequest, completionHandler: @escaping (URLRequest?) -> Void){
        print("willPerformHTTPRedirection response")
    }
    
    //urlSession(_:task:didFinishCollecting:)
    //Tells the delegate that the session finished collecting metrics for the task.
    @available(iOS 10.0, *)
    func urlSession(_ session: URLSession, task: URLSessionTask, didFinishCollecting metrics: URLSessionTaskMetrics){
        print("SISUATION \(metrics)")
        print("didFinishCollecting metrics")
        
    }
    
    
    
    
    //urlSession(_:task:didCompleteWithError:)
    //Tells the delegate that the task finished transferring data.
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?){
        if let e = error {
            OperationQueue.main.addOperation{
                self.delegator.notifyError(error: e.localizedDescription)
            }
            
        }
        
        print("didCompleteWithError")
    }
    
    //MARK:- URLSessionStreamDelegate
    //urlSession(_:readClosedFor:)
    //Tells the delegate that the read side of the underlying socket has been closed.
    @available(iOS 9.0, *)
    func urlSession(_ session: URLSession, readClosedFor streamTask: URLSessionStreamTask){
        print("readClosedFor streamTask")
    }
    
    //urlSession(_:writeClosedFor:)
    //Tells the delegate that the write side of the underlying socket has been closed.
    @available(iOS 9.0, *)
    func urlSession(_ session: URLSession, writeClosedFor streamTask: URLSessionStreamTask){
        print("writeClosedFor streamTask")
    }
    
    //urlSession(_:betterRouteDiscoveredFor:)
    //Tells the delegate that a better route to the host has been detected for the stream.
    @available(iOS 9.0, *)
    func urlSession(_ session: URLSession, betterRouteDiscoveredFor streamTask: URLSessionStreamTask){
        print("betterRouteDiscoveredFor streamTask")
    }
    
    //urlSession(_:streamTask:didBecome:outputStream:)
    //Tells the delegate that the stream task has been completed as a result of the stream task calling the captureStreams() method.
    @available(iOS 9.0, *)
    func urlSession(_ session: URLSession, streamTask: URLSessionStreamTask, didBecome inputStream: InputStream, outputStream: OutputStream){
        print("didBecome inputStream")
    }
    
    //MARK:- URLSessionDataDelegate
    //urlSession(_:dataTask:didReceive:completionHandler:)
    //Tells the delegate that the data task received the initial reply (headers) from the server.
    /*
     func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Void){
     
     print("SERVER RESPOSE \(response)")
     print("didReceive response")
     
     }
     */
    //urlSession(_:dataTask:didBecome:)
    //Tells the delegate that the data task was changed to a download task.
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didBecome downloadTask: URLSessionDownloadTask){
        print("didBecome downloadTask")
    }
    
    //urlSession(_:dataTask:didBecome:)
    //Tells the delegate that the data task was changed to a streamtask.
    @available(iOS 9.0, *)
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didBecome streamTask: URLSessionStreamTask){
        print("didBecome streamTask")
    }
    
    /*
     //urlSession(_:dataTask:willCacheResponse:completionHandler:)
     //Asks the delegate whether the data (or upload) task should store the response in the cache.
     func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, willCacheResponse proposedResponse: CachedURLResponse, completionHandler: @escaping (CachedURLResponse?) -> Void){
     print("")
     print("willCacheResponse proposedResponse")
     }
     */
    /*
     //MARK:- URLSessionDownloadDelegate
     //urlSession(_:downloadTask:didResumeAtOffset:expectedTotalBytes:)
     //Tells the delegate that the download task has resumed downloading.
     func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didResumeAtOffset fileOffset: Int64, expectedTotalBytes: Int64){
     print("downloadTask")
     }
     */
    //urlSession(_:downloadTask:didWriteData:totalBytesWritten:totalBytesExpectedToWrite:)
    //Periodically informs the delegate about the download’s progress.
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64){
        
       
        print("全部要下載 ----> \(totalBytesExpectedToWrite) 已經下載 ----> \(totalBytesWritten)")
        OperationQueue.main.addOperation {
            self.delegator.progressReport(persent: Double(totalBytesWritten)/Double(totalBytesExpectedToWrite))
        }
        
        if totalBytesExpectedToWrite == totalBytesWritten{
            print("DOWNLOAD COMPLETED!!!")
            
        }
        
    }
    
    //urlSession(_:downloadTask:didFinishDownloadingTo:)
    //Tells the delegate that a download task has finished downloading.
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL){
        print("didFinishDownloadingTo")
        
        if self.operation_type == TYPE.TEXT{
            let ttt = String(data: download_data, encoding: .utf8)
            
            OperationQueue.main.addOperation {
                self.delegator.notifyString(text: ttt!)
                
            }
            
        }else if self.operation_type == TYPE.IMAGE{
            let iii = UIImage(data: download_data)
            OperationQueue.main.addOperation {
                self.delegator.notifyImage(image: iii!)
            }
            
            
        }else{
            let bbb = download_data
            OperationQueue.main.addOperation {
                self.delegator.notifyByte(data: bbb)
            }
            
        }
        
        
    }
    
    
    //////
    
    
  
    
    
    func isNetworkReachable() -> Bool {
        
        //let reachability = SCNetworkReachabilityCreateWithName(nil, "www.google.com")
        
        var address = sockaddr_in()
        address.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        address.sin_family = sa_family_t(AF_INET)
        
        // Passes the reference of the struct
        let reachability = withUnsafePointer(to: &address, { pointer in
            // Converts to a generic socket address
            return pointer.withMemoryRebound(to: sockaddr.self, capacity: MemoryLayout<sockaddr>.size) {
                // $0 is the pointer to `sockaddr`
                return SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        })
        
        var flags = SCNetworkReachabilityFlags()
        SCNetworkReachabilityGetFlags(reachability!, &flags)
        
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        let canConnectAutomatically = flags.contains(.connectionOnDemand) || flags.contains(.connectionOnTraffic)
        let canConnectWithoutUserInteraction = canConnectAutomatically && !flags.contains(.interventionRequired)
        
        return isReachable && (!needsConnection || canConnectWithoutUserInteraction)
    }
    
    ////輸入代發單位的帳密
    
    func sendSmsVlidation(sms_url:String, account:String, password:String)->Bool{
        
        var validation = false
        var random_string = "0000"
        for _ in 1...5{
            let random_code = arc4random_uniform(_:9)
            random_string = random_string + String(random_code)
        }
        let orignal_server_place = self.server_url
        self.server_url = sms_url
        self.post_excute_data(
            variable_name: ["account","password", "code"],
            datas: [account,password,random_string]
        )
        self.server_url = orignal_server_place
        ///////
        
        let alertController = UIAlertController(title: "驗證電話號碼", message: "請輸入您簡訊中鐵票驗證碼", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addTextField { (textField : UITextField) -> Void in
            textField.placeholder = "驗證碼"
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) { (result : UIAlertAction) -> Void in
        }
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
            if random_string == alertController.textFields?[0].text{
                print("驗證OK")
                validation = true
            }
            
            
        }
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        
        //self.host_viewcontroller.present(alertController, animated: true, completion: nil)
        
        
        return validation
    }
    
    
    
    
}
