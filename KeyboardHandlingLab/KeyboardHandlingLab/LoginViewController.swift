//
//  LoginViewController.swift
//  KeyboardHandlingLab
//
//  Created by Gregory Keeley on 2/5/20.
//  Copyright © 2020 Gregory Keeley. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var userPasswordField: UITextField!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    
    @IBOutlet weak var passwordCenterYConstraint: NSLayoutConstraint!
    
    private var keyboardIsVisible = false
    private var originalFieldsYConstraint = NSLayoutConstraint()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userNameTextField.delegate = self
        userPasswordField.delegate = self
    }
    override func viewWillDisappear(_ animated: Bool) {
        unregisterForKeyboardNotifications()
    }
    private func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
                NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
    }
    private func unregisterForKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil )
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    @objc private func keyboardWillShow(_ notification: NSNotification) {
        guard let keyboardFrame = notification.userInfo?["UIKeyboardframeBeginUserInfoKey"] as? CGRect else {
           return
        }
        print(keyboardFrame.size.height)
        moveKeyboardUp(keyboardFrame.size.height)
    }
    private func moveKeyboardUp(_ height: CGFloat) {
        if keyboardIsVisible { return }
        originalFieldsYConstraint = passwordCenterYConstraint
        passwordCenterYConstraint.constant -= (height * 0.80)
        keyboardIsVisible = true
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    private func resetUI() {
        keyboardIsVisible = false
        passwordCenterYConstraint.constant -= originalFieldsYConstraint.constant
    }
    @objc private func keyboardWillHide(_ notification: NSNotification) {
        resetUI()
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
}
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
