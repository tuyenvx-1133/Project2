//
//  ViewControllerExt.swift
//  ProjectiOSTranning1.2018
//
//  Created by TuyenVX on 1/3/18.
//  Copyright © 2018 TuyenVX. All rights reserved.
//

import UIKit

extension UIViewController {
    static func loadFromStoryboard(_ storyboard: Storyboard) -> UIViewController {
        let identifier = String(describing: self)
        let storyboard = UIStoryboard(name: storyboard.rawValue, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: identifier)
    }
}
