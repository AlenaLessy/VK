//
//  LikeControl.swift
//  VK
//
//  Created by Алена Панченко on 05.11.2022.
//

import UIKit

final class LikeControl: UIControl {
    // MARK: - Constants

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
            likeImageView.image = UIImage(systemName: SystemImageName.heart)
            likeImageView.tintColor = .systemGray6
            numberOfLikes -= 1
            numberOfLikesLabel.text = numberOfLikes.description
            numberOfLikesLabel.textColor = .systemGray6

            return
        }
        likeImageView.image = UIImage(systemName: SystemImageName.heartFill)
        likeImageView.tintColor = .red
        numberOfLikes += 1
        numberOfLikesLabel.text = numberOfLikes.description
        numberOfLikesLabel.textColor = .red
    }

    private func setupRecognizer() {
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(recognizerAction(_:)))
        addGestureRecognizer(recognizer)
    }
}
