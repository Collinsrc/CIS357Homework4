//
//  ConversionCalcButton.swift
//  Homework 1
//
//  Created by Xcode User on 10/1/19.
//  Copyright © 2019 Xcode User. All rights reserved.
//

import UIKit

class ConversionCalcButton: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override func awakeFromNib() {
        self.backgroundColor = FOREGROUND_COLOR
        self.tintColor = BACKGROUND_COLOR
        self.layer.cornerRadius = 5.0
    }
}
