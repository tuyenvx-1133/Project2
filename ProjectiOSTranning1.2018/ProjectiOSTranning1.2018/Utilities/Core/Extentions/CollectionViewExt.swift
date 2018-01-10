//
//  CollectionViewExt.swift
//  ProjectiOSTranning1.2018
//
//  Created by TuyenVX on 1/8/18.
//  Copyright © 2018 TuyenVX. All rights reserved.
//

import UIKit

extension UICollectionView {
    func registerCell(_ cell: UICollectionViewCell.Type) {
        let idendifier = String(describing: cell)
        print(idendifier)
        self.register(UINib.init(nibName: idendifier, bundle: nil), forCellWithReuseIdentifier: idendifier)
    }
    func registerCell(_ cell: UICollectionReusableView.Type) {
        let idendifier = String(describing: cell)
        print(idendifier)
        self.register(UINib.init(nibName: idendifier, bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: idendifier)
    }
}
