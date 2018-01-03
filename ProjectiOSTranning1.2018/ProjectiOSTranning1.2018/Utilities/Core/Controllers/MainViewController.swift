//
//  MainViewController.swift
//  ProjectiOSTranning1.2018
//
//  Created by TuyenVX on 1/3/18.
//  Copyright © 2018 TuyenVX. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {
    override func awakeFromNib() {
        super.awakeFromNib()
        launch()
        self.tabBar.tintColor = UIColor.mainColor
    }
    func launch() {
        let launcbVC = LaunchViewController.loadFromStoryboard(.main)
        viewControllers = [launcbVC]
        hideTabbar(hide: true)
    }
    func createTabbar() {
        let momoTabNavigationCtrl = getInitialVC(ofStoryboard: .momo)
        momoTabNavigationCtrl.tabBarItem = tabbarItem(title: "MOMO", image: #imageLiteral(resourceName: "ic_tab_momo"), selectedImage: #imageLiteral(resourceName: "ic_tab_momo"))
        let specialTabNavigationCtrl = getInitialVC(ofStoryboard: .special)
        specialTabNavigationCtrl.tabBarItem = tabbarItem(title: "ƯU ĐÃI", image: #imageLiteral(resourceName: "ic_tab_special"), selectedImage: #imageLiteral(resourceName: "ic_tab_special"))
        let transactionTabNavigationCtrl = getInitialVC(ofStoryboard: .transaction)
        transactionTabNavigationCtrl.tabBarItem = tabbarItem(title: "LỊCH SỬ GD", image: #imageLiteral(resourceName: "ic_tab_transaction"), selectedImage: #imageLiteral(resourceName: "ic_tab_transaction"))
        let walletTabNavigationCtrl = getInitialVC(ofStoryboard: .wallet)
        walletTabNavigationCtrl.tabBarItem = tabbarItem(title: "VÍ CỦA TÔI", image: #imageLiteral(resourceName: "ic_tab_wallet"), selectedImage: #imageLiteral(resourceName: "ic_tab_wallet"))
        viewControllers = [momoTabNavigationCtrl, specialTabNavigationCtrl, transactionTabNavigationCtrl, walletTabNavigationCtrl]
        self.selectedIndex = 0
        hideTabbar(hide: false)
    }
    func tabbarItem(title: String, image: UIImage, selectedImage: UIImage) -> UITabBarItem {
        return UITabBarItem.init(title: title, image: image, selectedImage: selectedImage)
    }
    func hideTabbar(hide isHidden: Bool) {
        self.tabBar.isHidden = isHidden
    }
    func getInitialVC(ofStoryboard storyboardID: Storyboard) -> UIViewController {
        return UIStoryboard(name: storyboardID.rawValue, bundle: nil).instantiateInitialViewController()!
    }
}
