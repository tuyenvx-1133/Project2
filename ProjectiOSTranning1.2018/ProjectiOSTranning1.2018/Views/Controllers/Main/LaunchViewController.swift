//
//  LaunchViewController.swift
//  ProjectiOSTranning1.2018
//
//  Created by TuyenVX on 1/4/18.
//  Copyright © 2018 TuyenVX. All rights reserved.
//

import UIKit

class LaunchViewController: UIViewController {

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkLogin()
    }
    func checkLogin() {
        if true {
            gotoLogin()
        } else {
            gotoMainTab()
        }
    }
    func gotoLogin() {
        let loginVC = LoginViewController.loadFromStoryboard(.account)
        present(loginVC, animated: true, completion: nil)
    }
    func gotoMainTab() {
        dismiss(animated: true, completion: nil)
        mainViewController?.createTabbar()
    }
}
