// CustomInteractiveTransition.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Кастомное закрытие экрана
final class CustomInteractiveTransition: UIPercentDrivenInteractiveTransition {
    // MARK: - Private Constants

    private enum Constants {
        static let maxProgress: CGFloat = 0
        static let minProgress: CGFloat = 1
        static let thirdProgress: CGFloat = 0.33
        static let thirdBoundsWidth: CGFloat = 0.3
    }

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
            let relativeTranslation = translation.y / (recognizer.view?.bounds.width ?? Constants.thirdBoundsWidth)
            let progress = max(Constants.maxProgress, min(Constants.minProgress, relativeTranslation))
            isFinish = progress > Constants.thirdProgress
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
