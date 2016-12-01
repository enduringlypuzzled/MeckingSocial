//
//  FancyBtn.swift
//  MeckingSocial
//
//  Created by Steve Mecking on 2016-11-23.
//  Copyright © 2016 Steve Mecking. All rights reserved.
//

import UIKit

class FancyBtn: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
       
        layer.shadowColor = UIColor(red: SHADOW_GRAY, green: SHADOW_GRAY, blue: SHADOW_GRAY, alpha: 0.6).cgColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSize(width: 1, height: 1)
        layer.cornerRadius = 2.0
    }
}
