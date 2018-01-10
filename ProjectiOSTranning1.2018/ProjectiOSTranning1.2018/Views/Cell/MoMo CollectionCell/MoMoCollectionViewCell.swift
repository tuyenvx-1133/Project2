//
//  MoMoCollectionViewCell.swift
//  ProjectiOSTranning1.2018
//
//  Created by TuyenVX on 1/8/18.
//  Copyright © 2018 TuyenVX. All rights reserved.
//

import UIKit

class MoMoCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak private var imageView: UIImageView!
    @IBOutlet weak private var label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func fillData(data: [String: String]) {
        if let imageName = data[Keys.image] {
            imageView.image = UIImage.init(named: imageName)
        }
        label.text = data[Keys.title]
    }

}
