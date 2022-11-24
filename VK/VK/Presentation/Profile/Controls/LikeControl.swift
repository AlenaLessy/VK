// LikeControl.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Контрол для выставления и подсчета лайков
final class LikeControl: UIControl {
    // MARK: - Private Constants

    private enum SystemImageName {
        static let heartFill = "heart.fill"
        static let heart = "heart"
    }

    // MARK: - Private Outlets

    @IBOutlet private var likeImageView: UIImageView!
    @IBOutlet private var numberOfLikesLabel: UILabel!

    // MARK: - Private Properties

    private var isLiked = false
    private var numberOfLikes = 0

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupRecognizer()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupRecognizer()
    }

    // MARK: - Private Method

    @objc private func recognizerAction(_: UITapGestureRecognizer) {
        isLiked.toggle()
        guard isLiked else {
            setupDislike()
            return
        }
        setupLike()
    }

    private func setupRecognizer() {
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(recognizerAction(_:)))
        addGestureRecognizer(recognizer)
    }

    private func setupLike() {
        UIView.animate(withDuration: 0.5) {
            self.likeImageView.image = UIImage(systemName: SystemImageName.heartFill)
            self.likeImageView.tintColor = .red
            self.numberOfLikes += 1
            self.numberOfLikesLabel.text = self.numberOfLikes.description
            self.numberOfLikesLabel.textColor = .red
        }
    }

    private func setupDislike() {
        UIView.animate(withDuration: 0.5) {
            self.likeImageView.image = UIImage(systemName: SystemImageName.heart)
            self.likeImageView.tintColor = .white
            self.numberOfLikes -= 1
            self.numberOfLikesLabel.text = self.numberOfLikes.description
            self.numberOfLikesLabel.textColor = .white
        }
    }
}
