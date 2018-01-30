//
//  LineView.swift
//  ElectionLoginDemo
//
//  Created by EZoneLai Lai on 2017/7/22.
//  Copyright © 2017年 EZoneLai. All rights reserved.
//

import UIKit

class LineView: UIView {

    var fill_or_not:Bool = false
    var drawArea:CGRect!
    var lineColor:UIColor!
    
    init(drawArea: CGRect, frame: CGRect, lineColor:UIColor, fill_or_not:Bool = false) {
        super.init(frame: frame)
        self.drawArea = drawArea
        self.lineColor = lineColor
        self.fill_or_not = fill_or_not
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        let aPath = UIBezierPath()
        
        aPath.move(to: drawArea.origin)
        
        aPath.addLine(to: CGPoint(x:drawArea.origin.x + drawArea.size.width,
                                  y:drawArea.origin.y))
        
        aPath.addLine(to: CGPoint(x:drawArea.origin.x + drawArea.size.width,
                                  y:drawArea.origin.y + drawArea.size.height))
        
        aPath.addLine(to: CGPoint(x:drawArea.origin.x,
                                  y:drawArea.origin.y + drawArea.size.height))
        
        aPath.addLine(to: CGPoint(x:drawArea.origin.x,
                                  y:drawArea.origin.y))
        
        //Keep using the method addLineToPoint until you get to the one where about to close the path
        
        aPath.close()
        
        //If you want to stroke it with a  color
        //self.layer.borderColor = (self.lineColor as! CGColor)
        //UIColor.red.set()
        self.lineColor.set()
        
        aPath.stroke()
        //If you want to fill it as well
        if self.fill_or_not{
            aPath.fill()
        }
        
        let text = "--雙指縮放＼移動，讓需要的部份在黃色框內--"
        let text_size:CGFloat = 18
        let w:CGFloat = CGFloat(text.characters.count) * text_size
        //let h:CGFloat = text_size
        let _rect = CGRect(
            x: (rect.size.width - w)/2,
            y: text_size * 3,
            width: 400,
            height: text_size
        )
        
        drawMyText(myText: text, textColor: UIColor.yellow, FontName: "Helvetica Bold", FontSize: text_size , inRect:_rect)
        
    }
    
    
    func drawMyText(myText:String,textColor:UIColor, FontName:String, FontSize:CGFloat, inRect:CGRect){
        
        let textFont = UIFont(name: FontName, size: FontSize)!
        let p:NSMutableParagraphStyle = NSMutableParagraphStyle()
        p.alignment = NSTextAlignment.center
        let textFontAttributes = [
            NSFontAttributeName: textFont,
            NSForegroundColorAttributeName: textColor,
            NSParagraphStyleAttributeName: p
            ] as [String : Any]
        
        myText.draw(in: inRect, withAttributes: textFontAttributes)
    }
}
