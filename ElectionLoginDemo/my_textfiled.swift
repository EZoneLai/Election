//
//  my_textfiled.swift
//  iroiro
//
//  Created by EZoneLai Lai on 2017/8/12.
//  Copyright © 2017年 EZoneLai Lai. All rights reserved.
//

import UIKit

class my_textfiled: UITextField, UITextFieldDelegate {

    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        super.draw(rect)
        self.delegate = self
        
    }
    
    
    func textFieldAdjust(target: [UITextField]) {
        for textfield in target {
            textfield.adjustsFontSizeToFitWidth = true
            textfield.minimumFontSize = 12
        }
    }
    func numberKeyboard(target: [UITextField]) {
        for textfield in target {
            textfield.keyboardType = .numberPad
            textfield.minimumFontSize = 12
        }
    }

    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.resignFirstResponder()
        
        return true;
    }

}
