//
//  AlertViewController.swift
//  ProjectiOSTranning1.2018
//
//  Created by TuyenVX on 1/4/18.
//  Copyright © 2018 TuyenVX. All rights reserved.
//

import UIKit

enum AlertType {
    case forgetPassword
    case changePhoneNumber
    case logout
}

protocol AlertViewControllerDelegate: class {
    func didSelectRightButton(type: AlertType)
}
class AlertViewController: UIViewController {
    var info: [String: String] = [String: String]()
    var type: AlertType = AlertType.forgetPassword
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var messageLabel: UILabel!
    @IBOutlet weak private var leftButton: UIButton!
    @IBOutlet weak private var rightButton: UIButton!
    weak var delegate: AlertViewControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        setDefaults()
        showAlert()
    }
    // MARK: - Init
    func setDefaults() {
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(dismissVC))
        view.addGestureRecognizer(tapGesture)
    }
    func showAlert() {
        switch type {
        case .forgetPassword:
            info = [
                Keys.title: "Cài đặt lại mật khẩu",
                Keys.message: "Bạn đang yêu cầu đặt lại mật khẩu cho SĐT, một mật khẩu tạm thời sẽ được gửi đến SĐT này qua tin nhắn SMS sau khi bạn xác nhận. Bạn có chắc chắn muốn đặt lại mật khẩu?",
                Keys.leftButtonTitle: "HUỶ BỎ",
                Keys.rightButtonTitle: "XÁC NHẬN"
            ]
        case .changePhoneNumber:
            info = [
                Keys.title: "",
                Keys.message: "Bạn có chắc chắn muốn thay đổi số điện thoại của bạn?",
                Keys.leftButtonTitle: "HUỶ",
                Keys.rightButtonTitle: "ĐỒNG Ý"
            ]
        case .logout:
            info = [
                Keys.title: "Đăng xuất",
                Keys.message: "Bạn có muốn đăng xuất tài khoản này?",
                Keys.leftButtonTitle: "KHÔNG",
                Keys.rightButtonTitle: "ĐỒNG Ý"
            ]
        }
        titleLabel.text = info[Keys.title]
        messageLabel.text = info[Keys.message]
        leftButton.setTitle(info[Keys.leftButtonTitle], for: .normal)
        rightButton.setTitle(info[Keys.rightButtonTitle], for: .normal)
    }
    // MARK: - UIAction
    @IBAction func selectLeftButton(_ sender: Any) {
        dismissVC()
    }
    @IBAction func selectRightButton(_ sender: Any) {
        delegate?.didSelectRightButton(type: type)
        dismissVC()
    }
    // MARK: - Function
    @objc func dismissVC() {
        dismiss(animated: false, completion: nil)
    }
}
