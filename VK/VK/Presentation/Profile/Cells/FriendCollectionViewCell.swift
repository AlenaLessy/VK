// FriendCollectionViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка коллекции друзей
final class FriendCollectionViewCell: UICollectionViewCell {
    // MARK: - Public Outlets

    @IBOutlet var cellHeightLayoutConstraint: NSLayoutConstraint!

    // MARK: - Private Outlets

    @IBOutlet private var friendImageView: UIImageView!

    // MARK: - Public Method

    func update(friend: Friend) {
        guard let imageName = friend.imageNames.first else { return }
        friendImageView.image = UIImage(named: imageName)
    }

    func update(news: News) {
        guard let imageName = news.postImageName.imageNames.first else { return }
        friendImageView.image = UIImage(named: imageName)
    }
}
