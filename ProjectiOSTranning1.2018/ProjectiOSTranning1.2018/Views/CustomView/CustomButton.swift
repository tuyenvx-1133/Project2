//
//  CustomButton.swift
//  ProjectiOSTranning1.2018
//
//  Created by TuyenVX on 1/9/18.
//  Copyright © 2018 TuyenVX. All rights reserved.
//

import UIKit

class CustomButton: UIButton {
    override func awakeFromNib() {
        imageView?.contentMode = .scaleAspectFit
        titleLabel?.numberOfLines = 2
        titleLabel?.textAlignment = .center
        titleLabel?.font = UIFont.systemFont(ofSize: 12)
        self.setTitleColor(UIColor.lightGray, for: .highlighted)
    }

    override func draw(_ rect: CGRect) {
        upDate(percent: 1)
    }
    func upDate(percent: CGFloat) {
        var width = self.frame.width
        if percent == 0 {
            width = (Device.screenWidth - (Device.screenWidth / 3.0 - 20) - 45) / 4
        } else if percent == 1 {
            width = Device.screenWidth / 4
        }
        imageEdgeInsets = UIEdgeInsets.init(top: 12.5, left: width  * 0.3, bottom: 15, right: width  * 0.3)
        guard let size = imageView?.frame.size else { return  }
        titleEdgeInsets = UIEdgeInsets.init(top: size.height + 10, left: -size.width, bottom: 10, right: 0)
        titleLabel?.font = UIFont.systemFont(ofSize: percent * 12)
        titleLabel?.alpha = percent
    }
}
