//
//  LoginViewController.swift
//  ProjectiOSTranning1.2018
//
//  Created by TuyenVX on 1/4/18.
//  Copyright © 2018 TuyenVX. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak private var userNameLabel: UILabel!
    @IBOutlet weak private var phoneNumberLabel: UILabel!
    @IBOutlet weak private var passwordTextfield: UITextField!
    @IBOutlet weak private var wrongPasswordLabelHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak private var loginButton: UIButton!
    @IBOutlet weak private var fogetPasswordButton: UIButton!
    @IBOutlet weak private var changePhoneButton: UIButton!
    @IBOutlet weak private var fingerButton: UIButton!
    @IBOutlet weak private var mainView: UIView!
    @IBOutlet weak private var mainViewCenterYConstraint: NSLayoutConstraint!
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setDefaults()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addKeyBoardNotifi()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeKeyBoardNotifi()
    }
    // MARK: - Init
    func setDefaults() {
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(hideKeyboard))
        mainView.addGestureRecognizer(tapGesture)
        view.addGestureRecognizer(tapGesture)
    }
    // MARK: - IBAction
    @IBAction func login(_ sender: Any) {
        hideKeyboard()
        dismiss(animated: true, completion: nil)
        mainViewController?.createTabbar()
    }
    @IBAction func forgetPassword(_ sender: Any) {
        hideKeyboard()
        showAlert(type: .forgetPassword)
    }
    @IBAction func changePhoneNumber(_ sender: Any) {
        hideKeyboard()
        showAlert( type: .changePhoneNumber)
    }
    @IBAction func loginUsingFinger(_ sender: Any) {
        hideKeyboard()
    }
    // MARK: - Funtion
    func showAlert(type: AlertType) {
        guard let alertVC = AlertViewController.loadFromStoryboard(.main) as? AlertViewController else {
            return
        }
        alertVC.type = type
        alertVC.modalPresentationStyle = .custom
        alertVC.delegate = self
        present(alertVC, animated: false, completion: nil)
    }
    func showWrongPasswordLabel() {
        wrongPasswordLabelHeightConstraint.constant = 35
    }
    // MARK: - Keyboard
    func addKeyBoardNotifi() {
        NotificationCenter.default.addObserver( self, selector: #selector(keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver( self, selector: #selector(keyBoardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    func removeKeyBoardNotifi() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            let distance = keyboardHeight + mainView.frame.size.width/2.0 - Device.screenHeight/2.0 - 35
            if distance > 0 {
                UIView.transition(with: view, duration: 0.25, options: .allowAnimatedContent, animations: {
                    self.mainViewCenterYConstraint.constant = -distance
                }, completion: {_ in
                    //
                })
            }
        }
    }
    @objc func keyBoardWillHide(_ notification: Notification) {
        UIView.transition(with: view, duration: 0.25, options: .allowAnimatedContent, animations: {
            self.mainViewCenterYConstraint.constant = 0
        }, completion: nil)
    }
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
}
// MARK: - AlertViewController Delegate
extension LoginViewController: AlertViewControllerDelegate {
    func didSelectRightButton(type: AlertType) {
        switch type {
        case .forgetPassword:
            print("Alert forgetpass")
        case .changePhoneNumber:
            print("Alert changePhoneNumber")
        }
    }
}
