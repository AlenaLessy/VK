//
//  CustomPopAnimator.swift
//  VK
//
//  Created by Алена Панченко on 11.11.2022.
//

import UIKit

/// Анимация при поп переходе
final class CustomPopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    // MARK: - Private Constants

    private enum Constants {
        static let timeInterval: Double = 1
        static let translationFrameWidthX: CGFloat = -1
        static let translationFrameWidthY: CGFloat = 2
        static let rotationOfPiAngel: CGFloat = 2
        static let delay = 0.0
        static let relativeStartTime: Double = 0
        static let relativeDisappearingVCDuration = 0.3
        static let relativeEmergingVCDuration = 0.75
        static let animateKeyframesTranslationOfFrameWidthX: CGFloat = 1.5
        static let animateKeyframesTranslationY: CGFloat = 0
    }

    // MARK: - Public Methods

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        Constants.timeInterval
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let source = transitionContext.viewController(forKey: .from),
            let destination = transitionContext.viewController(forKey: .to)
        else {
            return
        }

        transitionContext.containerView.addSubview(destination.view)
        transitionContext.containerView.sendSubviewToBack(destination.view)
        destination.view.frame = source.view.frame
        let rotation = CGAffineTransform(rotationAngle: .pi / Constants.rotationOfPiAngel)
        let translation = CGAffineTransform(
            translationX: source.view.frame.width * Constants.translationFrameWidthX,
            y: source.view.frame.width / Constants.translationFrameWidthY
        )
        let durations = transitionDuration(using: transitionContext)
        destination.view.transform = rotation.concatenating(translation)
        transitionAnimations(
            transitionContext: transitionContext,
            source: source,
            destination: destination,
            durations: durations
        )
    }

    // MARK: - Private Methods

    private func transitionAnimations(
        transitionContext: UIViewControllerContextTransitioning,
        source: UIViewController,
        destination: UIViewController,
        durations: TimeInterval
    ) {
        UIView.animateKeyframes(
            withDuration: transitionDuration(using: transitionContext),
            delay: Constants.delay,
            options: .calculationModePaced,
            animations: {
                UIView.addKeyframe(
                    withRelativeStartTime: Constants.relativeStartTime,
                    relativeDuration: Constants.relativeDisappearingVCDuration
                ) {
                    let rotation = CGAffineTransformMakeRotation(-.pi / Constants.rotationOfPiAngel)
                    let translation = CGAffineTransform(
                        translationX: source.view.frame.width * Constants.animateKeyframesTranslationOfFrameWidthX,
                        y: Constants.animateKeyframesTranslationY
                    )
                    source.view.transform = rotation.concatenating(translation)
                }

                UIView.addKeyframe(
                    withRelativeStartTime: Constants.relativeStartTime,
                    relativeDuration: Constants.relativeEmergingVCDuration
                ) {
                    destination.view.transform = .identity
                }
            }
        ) { finished in
            if finished, !transitionContext.transitionWasCancelled {
                source.removeFromParent()
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
