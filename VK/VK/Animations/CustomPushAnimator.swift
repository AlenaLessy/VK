//
//  CustomPushAnimator.swift
//  VK
//
//  Created by Алена Панченко on 11.11.2022.
//

import UIKit

/// Анимация при пуш переходе
final class CustomPushAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    // MARK: - Public Methods

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        1
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let source = transitionContext.viewController(forKey: .from),
              let destination = transitionContext.viewController(forKey: .to)
        else { return }

        transitionContext.containerView.addSubview(destination.view)
        destination.view.frame = source.view.frame
        let rotation = CGAffineTransform(rotationAngle: -.pi / 2)
        let translation = CGAffineTransform(
            translationX: source.view.frame.width * 1.5,
            y: -source.view.frame.width / 2
        )
        destination.view.transform = rotation.concatenating(translation)

        UIView.animateKeyframes(
            withDuration: transitionDuration(using: transitionContext),
            delay: 0,
            options: .calculationModePaced,
            animations: {
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.75) {
                    let rotation = CGAffineTransformMakeRotation(.pi / 2)
                    let translation = CGAffineTransform(translationX: -(source.view.frame.width), y: 0)
                    source.view.transform = rotation.concatenating(translation)
                }

                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.75) {
                    destination.view.transform = .identity
                }
            }
        ) { finished in
            if finished, !transitionContext.transitionWasCancelled {
                source.view.transform = .identity
                //  source.removeFromParent()
            } else if transitionContext.transitionWasCancelled {
                destination.view.transform = .identity
            }
            transitionContext.completeTransition(
                finished &&
                    !transitionContext.transitionWasCancelled
            )
        }
    }
}
