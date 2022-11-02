//
//  ViewController.swift
//  VK
//
//  Created by Алена Панченко on 01.11.2022.
//

import UIKit

/// Экран входа
final class LoginViewController: UIViewController {
    // MARK: - Constants
    
    private enum Constants {
        static let homeIdentifierName = "home"
        static let alertTitleText = "Внимание!"
        static let alertMessageWrongPassText = "Пароль и/или логин введен неверно!"
        static let alertActionTitleText = "Ok"
        static let alertMessageEmptyFieldsText = "Заполните логин и пароль"
        static let userLogin = "admin"
        static let userPassword = "12345"
    }
    
    // MARK: - Private Outlets
    
    @IBOutlet private var loginScrollView: UIScrollView!
    @IBOutlet private var loginTextField: UITextField!
    @IBOutlet private var passwordTextField: UITextField!
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addKeyboardObserver()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeKeyboardObserver()
    }
    
    // MARK: - Override Public Methods
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == Constants.homeIdentifierName {
            if authenticationInfo() {
                return true
            }
        }
        return true
    }
    
    // MARK: - Private Actions
    
    @objc private func keyboardWillShowAction(notification: Notification) {
        let info = notification.userInfo as? NSDictionary
        let kbSize = (info?.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as? NSValue)?.cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize?.height ?? 0.0, right: 0.0)
        loginScrollView.contentInset = contentInsets
    }
    
    @objc private func keyboardWillHideAction(notification: Notification) {
        loginScrollView.contentInset = UIEdgeInsets.zero
        loginScrollView.scrollIndicatorInsets = UIEdgeInsets.zero
    }
    
    @objc private func hideKeyboardAction() {
        loginScrollView.endEditing(true)
    }
    
    // MARK: Private Method
    
    private func authenticationInfo() -> Bool {
        guard let login = loginTextField.text,
              !login.isEmpty,
              let password = passwordTextField.text
                !password.isEmpty
        else {
            showAlert(
                title: Constants.alertTitleText,
                message: Constants.alertMessageEmptyFieldsText,
                actionTitle: Constants.alertActionTitleText,
                handler: nil
            )
            return false
        }
        guard login.lowercased() == Constants.userLogin.lowercased(),
              password.lowercased() == Constants.userPassword.lowercased()
        else {
            showAlert(
                title: Constants.alertTitleText,
                message: Constants.alertMessageWrongPassText,
                actionTitle: Constants.alertActionTitleText,
                handler: nil
            )
            return false
        }
        return true
    }
    
    private func addKeyboardObserver() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShowAction),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHideAction),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardAction))
        loginScrollView.addGestureRecognizer(tapGesture)
    }
    
    private func removeKeyboardObserver() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }
}
