//
//  Loading.swift
//  VK
//
//  Created by Алена Панченко on 09.11.2022.
//

import UIKit

/// Анимация загрузки
final class Loading: UIView {
    // MARK: - Private Constants

    private enum Constants {
        static let basicAnimationKeyPath = "opacity"
    }

    // MARK: - Private Visual Components

    private var leftPointView = UIView()
    private var middlePointView = UIView()
    private var rightPointView = UIView()

    private lazy var loadingStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.frame = CGRect(origin: .zero, size: frame.size)
        stackView.axis = .horizontal
        stackView.spacing = 7
        stackView.distribution = .fillEqually
        return stackView
    }()

    private lazy var points: [UIView] = [leftPointView, middlePointView, rightPointView]

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLoadingView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureLoadingView()
    }

    // MARK: - Private Methods

    private func configureLoadingView() {
        points.forEach {
            $0.layer.cornerRadius = bounds.height / 2
            $0.backgroundColor = .systemGray
            $0.alpha = 0.3
            loadingStackView.addArrangedSubview($0)
        }
        addSubview(loadingStackView)
        setupAnimate()
    }

    private func animateConfigure(view: UIView, retardation: Double) {
        let animate = CABasicAnimation(keyPath: Constants.basicAnimationKeyPath)
        animate.beginTime = .init() + retardation
        animate.fromValue = 0.7
        animate.duration = 0.5
        animate.toValue = 0.1
        animate.repeatCount = .greatestFiniteMagnitude
        animate.autoreverses = true
        view.layer.add(animate, forKey: nil)
    }

    private func setupAnimate() {
        var retardation = 0.0
        points.forEach {
            retardation += 0.3
            animateConfigure(view: $0, retardation: retardation)
        }
    }
}
