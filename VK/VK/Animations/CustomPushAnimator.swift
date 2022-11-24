// CustomPushAnimator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Анимация при пуш переходе
final class CustomPushAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    // MARK: - Private Constants

    private enum Constants {
        static let timeInterval = 1.0
        static let translationFrameWidthX = 1.5
        static let translationFrameWidthY: CGFloat = 2
        static let rotationOfPiAngel: CGFloat = 2
        static let delay = 0.0
        static let relativeStartTime = 0.0
        static let relativeDuration = 0.75
        static let animateKeyframesTranslationY: CGFloat = 0
    }

    // MARK: - Public Methods

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        Constants.timeInterval
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let source = transitionContext.viewController(forKey: .from),
              let destination = transitionContext.viewController(forKey: .to)
        else { return }

        transitionContext.containerView.addSubview(destination.view)
        destination.view.frame = source.view.frame
        let rotation = CGAffineTransform(rotationAngle: -.pi / Constants.rotationOfPiAngel)
        let translation = CGAffineTransform(
            translationX: source.view.frame.width * Constants.translationFrameWidthX,
            y: -source.view.frame.width / Constants.translationFrameWidthY
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
            withDuration: durations,
            delay: Constants.delay,
            options: .calculationModePaced,
            animations: {
                UIView.addKeyframe(
                    withRelativeStartTime: Constants.relativeStartTime,
                    relativeDuration: Constants.relativeDuration
                ) {
                    let rotation = CGAffineTransformMakeRotation(.pi / Constants.rotationOfPiAngel)
                    let translation = CGAffineTransform(
                        translationX: -(source.view.frame.width),
                        y: Constants.animateKeyframesTranslationY
                    )
                    source.view.transform = rotation.concatenating(translation)
                }

                UIView.addKeyframe(
                    withRelativeStartTime: Constants.relativeStartTime,
                    relativeDuration: Constants.relativeDuration
                ) {
                    destination.view.transform = .identity
                }
            }, completion: { finished in
                if finished, !transitionContext.transitionWasCancelled {
                    source.view.transform = .identity
                } else if transitionContext.transitionWasCancelled {
                    destination.view.transform = .identity
                }
                transitionContext.completeTransition(
                    finished &&
                        !transitionContext.transitionWasCancelled
                )
            }
        )
    }
}
