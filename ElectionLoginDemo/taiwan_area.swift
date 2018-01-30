//
//  taiwan_area.swift
//  ElectionLoginDemo
//
//  Created by EZoneLai on 2017/2/27.
//  Copyright © 2017年 EZoneLai. All rights reserved.
//

import UIKit

struct taiwan_area{
    //紀錄色塊資料 "區或里名""[R, G, B, A], 最後一個不要逗號
    var taiwan_area_color:[String:[UInt8]] =
        [
            "臺北市":[200, 200, 245, 255],
            "新北市":[200, 255, 175, 255],
            "基隆市":[255, 180, 205, 255],
            "桃園市":[170, 255, 240, 255],
            "新竹市":[255, 181, 205, 255],
            "新竹縣":[200, 201, 245, 255],
            "苗栗縣":[201, 255, 175, 255],
            "彰化縣":[255, 182, 205, 255],
            "雲林縣":[170, 255, 241, 255],
            "嘉義市":[255, 183, 205, 255],
            "嘉義縣":[202, 255, 175, 255],
            "臺中市":[170, 255, 242, 255],
            "南投縣":[200, 202, 245, 255],
            "臺南市":[200, 203, 245, 255],
            "高雄市":[255, 184, 205, 255],
            "屏東縣":[170, 255, 243, 255],
            "宜蘭縣":[255, 185, 205, 255],
            "花蓮縣":[203, 255, 175, 255],
            "臺東縣":[200, 204, 245, 255],
            /*"澎湖縣":[205,186,255,255],
             "金門縣":[245,205,200,255],
             "連江縣":[175,255,204,255]
             */
    ]
    
    var taiwan_area_meta:[String:String] =
        [
            //"圖檔中文名稱":"檔案的完整名稱", 最後一個不要逗號
            "台灣省":"TaiwanView",
            "基隆市":"",
            "臺北市":"TaipeiCityView",
            "新北市":"NewTaipeiCityView",
            "桃園市":"TaoyuanCityView",
            "新竹市":"",
            "新竹縣":"",
            "苗栗縣":"",
            "彰化縣":"",
            "雲林縣":"",
            "嘉義市":"",
            "嘉義縣":"",
            "臺中市":"",
            "南投縣":"",
            "臺南市":"",
            "高雄市":"",
            "屏東縣":"",
            "宜蘭縣":"",
            "花蓮縣":"",
            "臺東縣":"",
            "澎湖縣":"",
            "金門縣":"",
            "連江縣":""
            ]
    /*
    var name_area:[String:UIImage] = [
    
    "基隆市":KeelungCityImage,
    "臺北市":TaipeiCityImage,
    "新北市":NewTaipeiCityImage,
    "桃園市":TaoyuanCityImage,
    "新竹市":HsinchuCityImage,
    "新竹縣":HsinchuCountyImage,
    "苗栗縣":MiaoliCountyImage,
    "彰化縣":ChanghuaCountyImage,
    "雲林縣":YunlinCountyImage,
    "嘉義市":ChiayiCityImage,
    "嘉義縣":ChiayiCountyImage,
    "臺中市":TaichungCityImage,
    "南投縣":NantouCountyImage,
    "臺南市":TainanCityImage,
    "高雄市":KaohsiungCityImage,
    "屏東縣":PingtungCountyImage,
    "宜蘭縣":YilanCountyImage,
    "花蓮縣":HualienCountyImage,
    "臺東縣":TaitungCountyImage,
    //"澎湖縣":TaipeiCityImage,
    //"金門縣":TaipeiCityImage,
    //"連江縣":TaipeiCityImage
    ]
    */
}






























