//
//  CustomInteractiveTransition.swift
//  VK
//
//  Created by Алена Панченко on 11.11.2022.
//

import UIKit

final class CustomInteractiveTransition: UIPercentDrivenInteractiveTransition {
    // MARK: - Public properties

    var viewController: UIViewController? {
        didSet {
            let recognizer = UIScreenEdgePanGestureRecognizer(
                target: self,
                action: #selector(screenEdgeGestureRecognizerAction(_:))
            )
            recognizer.edges = [.left]
            viewController?.view.addGestureRecognizer(recognizer)
        }
    }

    var isStarted = false

    // MARK: - Private properties

    private var isFinish = false

    // MARK: - Private Method

    @objc private func screenEdgeGestureRecognizerAction(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            isStarted = true
            viewController?.navigationController?.popViewController(animated: true)
        case .changed:
            let translation = recognizer.translation(in: recognizer.view)
            let relativeTranslation = translation.y / (recognizer.view?.bounds.width ?? 0.3)
            let progress = max(0, min(1, relativeTranslation))
            isFinish = progress > 0.33
            update(progress)
        case .ended:
            isStarted = false
            if isFinish {
                finish()
            } else {
                cancel()
            }
        case .cancelled:
            isStarted = false
            cancel()
        default:
            return
        }
    }
}
