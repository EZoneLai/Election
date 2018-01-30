//
//  AreaIconView.swift
//  ElectionLoginDemo
//
//  Created by EZoneLai on 2017/2/27.
//  Copyright © 2017年 EZoneLai. All rights reserved.
//

import UIKit
////處理本區域的一些事件
protocol AreaIconviewDelegate {
    
    //VARIABLE
    //地圖區域變數
    var map_area:String!{set get}
    //選擇變數
    var choose:String!{set get}
    
    //////FUNCTION
    
    func test();
    
    func enlarge(tag:Int);
    func shrink(tag:Int);
}


class AreaIconView: UIImageView {
     /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    var delegate:AreaIconviewDelegate!

    var map_area:String!
    ////覆寫觸控函數
    
    //手指觸及
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch:UITouch = touches.first!
        let point:CGPoint = touch.location(in: self)
        let colors:[UInt8] = self.getPixelColorAtLocation(point: point)
        //print(colors)
        
        //由map_area決定該讀取哪個地區的json
        
        let path_to_json = Bundle.main.path(forResource: map_area, ofType: "json")!
        
        let data_from_json = NSData(contentsOfFile: path_to_json)! as Data
        
        do{
            
            let json_obj = try JSONSerialization.jsonObject(with: data_from_json, options: JSONSerialization.ReadingOptions.allowFragments) as! [String:Any]
            
            let color_obj = json_obj["colors"] as! [String:[UInt8]]
            
            /////只要判定點到哪一區(的名字)
            var which_area:String = ""
            //從我們設計的資料中taiwan_area()取出他的顏色（key:value)來對點到的區域顏色是否相同
            
            for  key in color_obj.keys{
                let temp_color = color_obj[key]! as [UInt8]
                //print("LIST----->\(temp_color)")
                //如果顏色相同，就將key指定是該區域，例如臺北市
                if colors == temp_color{
                    which_area = key
                }
            }
            //得到該區域就繼承該區域的delegate
            self.delegate.map_area = map_area
            //依照對應的key去告訴choose這個值，同時繼承他的delegate
            self.delegate.choose = which_area
            print("現在是\(map_area)，你點了\(which_area)")
            
            //解析上述delegate所包含的JSON資料，取出tag
            let tag_obj = json_obj["imageview"] as! [String:Int]
            //如果點到的區域沒有tag表示他沒點在對應的區域，例如海上
            if tag_obj[which_area] != nil{
                let which_tag = tag_obj[which_area]!
                print("TAG\(which_tag)")
                self.delegate.enlarge(tag: which_tag)
            }else{
                print("你點的區域沒有tag")
                return
            }
        }catch{
            //TODO: - 抓取顏色或解析JSON失敗
            print("你點的區域沒有tag或缺乏對應區塊")
        }
        
        
       
        
        
        
    }

    
    //手指抬起
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch:UITouch = touches.first!
        let point:CGPoint = touch.location(in: self)
        let colors:[UInt8] = self.getPixelColorAtLocation(point: point)
        
        //由map_area決定該讀取哪個地區的json
        
        let path_to_json = Bundle.main.path(forResource: map_area, ofType: "json")!
        
        let data_from_json = NSData(contentsOfFile: path_to_json)! as Data
        
        do{
            
            let json_obj = try JSONSerialization.jsonObject(with: data_from_json, options: JSONSerialization.ReadingOptions.allowFragments) as! [String:Any]
            
            let color_obj = json_obj["colors"] as! [String:[UInt8]]
            
            /////只要判定點到哪一區(的名字)
            var which_area:String = ""
            //從我們設計的資料中taiwan_area()取出他的顏色（key:value)來對點到的區域顏色是否相同
            
            for  key in color_obj.keys{
                
                let temp_color = color_obj[key]! as [UInt8]
                //print("LIST----->\(temp_color)")
                //如果顏色相同，就將key指定是該區域
                if colors == temp_color{
                    which_area = key
                }
                
            }
            
            self.delegate.map_area = map_area
            self.delegate.choose = which_area
            print("現在是\(map_area)，你點了\(which_area)")
            
            let tag_obj = json_obj["imageview"] as! [String:Int]
            if tag_obj[which_area] != nil{
                let which_tag = tag_obj[which_area]!
            
                print("TAG\(which_tag)")
            
                self.delegate.shrink(tag: which_tag)
            }else{
                print("你點的區域沒有tag")
                return
            }
        }catch{
            //TODO: - 抓取顏色或解析JSON失敗
            print("你點的區域沒有tag或缺乏對應區塊")
        }

        
/////由變數map_area來判定點到哪一區。
//        for key in self.delegate.area_data.keys{
//            if self.delegate.area_data[key]! == colors{
//                print("\(key)")
//                self.delegate.shrink(view_to_handle: key)
//                self.delegate.update_tableview!(tableview: self.delegate.tableview_to_update, which_area: key)
//            }
//        }
        
        
        
        
    }
        ///////辨識觸及的點的三原色函數
    
    /*  Objective C 版
     
     -(NSArray*) getPixelColorAtLocation:(CGPoint)point
     {
     unsigned char pixel[4] = {0};
     CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
     CGContextRef context = CGBitmapContextCreate(pixel, 1, 1, 8, 4, colorSpace, kCGImageAlphaPremultipliedLast);
     
     CGContextTranslateCTM(context, -point.x, -point.y);
     
     [self.layer renderInContext:context];
     
     // NSLog(@"x- %f  y- %f",point.x,point.y);
     
     CGContextRelease(context);
     CGColorSpaceRelease(colorSpace);
     
     //NSLog(@"RGB Color code %d  %d  %d",pixel[0],pixel[1],pixel[2]);
     
     NSString* r = [NSString stringWithFormat:@"%d",pixel[0]];
     NSString* g = [NSString stringWithFormat:@"%d",pixel[1]];
     NSString* b = [NSString stringWithFormat:@"%d",pixel[2]];
     
     return [[NSArray alloc]initWithObjects:r,g,b, nil];
     }
     */
    
    
    /////   swift 版
    func getPixelColorAtLocation(point:CGPoint)->[UInt8]{
        let pixel : [UInt8] = [0, 0, 0, 0]
        var colorSpace:CGColorSpace
        colorSpace = CGColorSpaceCreateDeviceRGB()
        var context:CGContext
        context = CGContext(
                data: UnsafeMutablePointer(mutating: pixel),
                width: 1,
                height: 1,
                bitsPerComponent: 8,
                bytesPerRow: 4,
                space: colorSpace,
                bitmapInfo: CGImageAlphaInfo.premultipliedFirst.rawValue | CGBitmapInfo.byteOrder32Little.rawValue)!
        context.translateBy(x: -point.x, y: -point.y)
        self.layer.render(in: context)
        //print("\(pixel[0]),\(pixel[1]),\(pixel[2]),\(pixel[3])")
        return pixel
    }
}



