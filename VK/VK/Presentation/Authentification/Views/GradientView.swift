//
//  GradientView.swift
//  VK
//
//  Created by Алена Панченко on 06.11.2022.
//

import UIKit

/// Вью градиента
final class GradientView: UIView {
    // MARK: - Public Properties

    override static var layerClass: AnyClass {
        CAGradientLayer.self
    }

    // MARK: - Private Properties

    private var gradientLayer: CAGradientLayer? {
        layer as? CAGradientLayer
    }

    @IBInspectable private var startColor: UIColor = .blue {
        didSet {
            gradientLayer?.colors = [startColor.cgColor, endColor.cgColor]
        }
    }

    @IBInspectable private var endColor: UIColor = .green {
        didSet {
            updateColors()
        }
    }

    @IBInspectable private var startLocation: CGFloat = 0 {
        didSet {
            updateLocations()
        }
    }

    @IBInspectable private var endLocation: CGFloat = 1 {
        didSet {
            updateLocations()
        }
    }

    @IBInspectable private var startPoint: CGPoint = .zero {
        didSet {
            updateStartPoint()
        }
    }

    @IBInspectable private var endPoint: CGPoint = .init(x: 0, y: 1) {
        didSet {
            updateEndPoint()
        }
    }

    // MARK: - Private methods

    private func updateColors() {
        gradientLayer?.colors = [startColor.cgColor, endColor.cgColor]
    }

    private func updateLocations() {
        gradientLayer?.locations = [startLocation as NSNumber, endLocation as NSNumber]
    }

    private func updateStartPoint() {
        gradientLayer?.startPoint = startPoint
    }

    private func updateEndPoint() {
        gradientLayer?.endPoint = endPoint
    }
}
