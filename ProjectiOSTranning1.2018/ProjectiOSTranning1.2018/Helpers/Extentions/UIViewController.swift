//
//  UIViewController.swift
//  ProjectiOSTranning1.2018
//
//  Created by TuyenVX on 1/3/18.
//  Copyright © 2018 TuyenVX. All rights reserved.
//

import UIKit

extension UIViewController {
    var mainViewController: MainViewController? {
        if let _mainViewController = self.tabBarController as? MainViewController {
            return _mainViewController
        }
        return self.view.window?.rootViewController as? MainViewController
    }
}
