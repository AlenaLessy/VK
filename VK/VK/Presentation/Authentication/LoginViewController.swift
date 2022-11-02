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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addKeyboardObserver()
        addGesture()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeKeyboardObserver()
    }

    // MARK: - Public Methods

    override func shouldPerformSegue(withIdentifier identifier: String, sender _: Any?) -> Bool {
        guard identifier == Constants.homeIdentifierName,
              emptyInfo(),
              authenticationInfo()
        else {
            return false
        }
        return true
    }

    // MARK: Private Method

    @objc private func keyboardWillShowAction(notification: Notification) {
        let info = notification.userInfo as? NSDictionary
        let kbSize = (info?.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as? NSValue)?.cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize?.height ?? 0.0, right: 0.0)
        loginScrollView.contentInset = contentInsets
    }

    @objc private func keyboardWillHideAction(notification _: Notification) {
        loginScrollView.contentInset = UIEdgeInsets.zero
        loginScrollView.scrollIndicatorInsets = UIEdgeInsets.zero
    }

    @objc private func hideKeyboardAction() {
        loginScrollView.endEditing(true)
    }

    private func emptyInfo() -> Bool {
        guard let login = loginTextField.text,
              !login.isEmpty,
              let password = passwordTextField.text,
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
        return true
    }

    private func authenticationInfo() -> Bool {
        guard
            let login = loginTextField.text,
            login.lowercased() == Constants.userLogin.lowercased(),
            let password = passwordTextField.text,
            password == Constants.userPassword
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
    }

    private func addGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardAction))
        loginScrollView.addGestureRecognizer(tapGesture)
    }

    private func removeKeyboardObserver() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }
}
