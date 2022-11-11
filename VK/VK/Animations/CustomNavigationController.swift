//
//  CustomNavigationController.swift
//  VK
//
//  Created by Алена Панченко on 11.11.2022.
//

import UIKit

/// Кастомный навигейшн с анимацией
final class CustomNavigationViewController: UINavigationController {
    // MARK: - Private Properties

    private let interactiveTransition = CustomInteractiveTransition()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        addNavigationControllerDelegate()
    }
    
    // MARK: - Private Methods
    private func addNavigationControllerDelegate() {
        delegate = self
    }
}

/// UINavigationControllerDelegate
extension CustomNavigationViewController: UINavigationControllerDelegate {
    func navigationController(
        _ navigationController: UINavigationController,
        animationControllerFor operation: UINavigationController.Operation,
        from fromVC: UIViewController,
        to toVC: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        switch operation {
        case .push:
            interactiveTransition.viewController = toVC
            return CustomPushAnimator()
        case .pop:
            if navigationController.viewControllers.first != toVC {
                interactiveTransition.viewController = toVC
            }
            return CustomPopAnimator()
        default:
            return nil
        }
    }

    func navigationController(
        _ navigationController: UINavigationController,
        interactionControllerFor animationController: UIViewControllerAnimatedTransitioning
    ) -> UIViewControllerInteractiveTransitioning? {
        interactiveTransition.isStarted ? interactiveTransition : nil
    }
}
