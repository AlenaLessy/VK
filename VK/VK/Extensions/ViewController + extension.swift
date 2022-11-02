//
//  ViewController + extension.swift
//  VK
//
//  Created by Алена Панченко on 02.11.2022.
//

import UIKit

/// Универсальный алерт
public extension UIViewController {
    func showAlert(title: String?, message: String?, actionTitle: String?, handler: ((UIAlertAction) -> ())?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: actionTitle, style: .default, handler: handler)
        alertController.addAction(alertAction)
        present(alertController, animated: true)
    }
}
