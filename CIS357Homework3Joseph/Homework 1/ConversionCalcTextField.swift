//
//  ConversionCalcTextField.swift
//  Homework 1
//
//  Created by Xcode User on 10/1/19.
//  Copyright © 2019 Xcode User. All rights reserved.
//

import UIKit

class ConversionCalcTextField: DecimalMinusTextField {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override func awakeFromNib() {
        self.tintColor = FOREGROUND_COLOR   
        self.textColor = FOREGROUND_COLOR
        self.backgroundColor = UIColor.clear
        self.layer.borderWidth = 1.0
        self.layer.borderColor = FOREGROUND_COLOR.cgColor
        self.layer.cornerRadius = 5.0
        guard let ph = self.placeholder else {
            return
        }
        self.attributedPlaceholder = NSAttributedString(string: ph, attributes: [NSAttributedString.Key.foregroundColor: FOREGROUND_COLOR])
    }
}
