//
//  ConversionCalcLabel.swift
//  Homework 1
//
//  Created by Xcode User on 10/1/19.
//  Copyright © 2019 Xcode User. All rights reserved.
//

import UIKit

class ConversionCalcLabel: UILabel {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override func awakeFromNib() {
        self.textColor = FOREGROUND_COLOR
    }

}
