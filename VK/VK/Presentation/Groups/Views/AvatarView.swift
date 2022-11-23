// AvatarView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Вью аватарки
final class AvatarView: UIView {
    // MARK: - Private Properties

    @IBInspectable private var shadowColor: UIColor = .black {
        didSet {
            updateShadowColor()
            setNeedsDisplay()
        }
    }

    @IBInspectable private var shadowOpacity: Float = 0.8 {
        didSet {
            updateShadowOpacity()
            setNeedsDisplay()
        }
    }

    @IBInspectable private var shadowRadius: CGFloat = 8 {
        didSet {
            updateShadowRadius()
            setNeedsDisplay()
        }
    }

    @IBInspectable private var shadowOffset: CGSize = .zero {
        didSet {
            updateShadowOffset()
            setNeedsDisplay()
        }
    }

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
    }

    // MARK: - Private Methods

    private func configureView() {
        updateShadowColor()
        updateShadowOpacity()
        updateShadowRadius()
        updateShadowOffset()
    }

    private func updateShadowColor() {
        layer.shadowColor = shadowColor.cgColor
    }

    private func updateShadowOpacity() {
        layer.shadowOpacity = shadowOpacity
    }

    private func updateShadowRadius() {
        layer.shadowRadius = shadowRadius
    }

    private func updateShadowOffset() {
        layer.shadowOffset = shadowOffset
    }
}
