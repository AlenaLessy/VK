//
//  FriendCollectionViewCell.swift
//  VK
//
//  Created by Алена Панченко on 05.11.2022.
//

import UIKit

/// Ячейка коллекции друзей
final class FriendCollectionViewCell: UICollectionViewCell {
    // MARK: - Public Outlets

    @IBOutlet var cellHeightLayoutConstraint: NSLayoutConstraint!

    // MARK: - Private Outlets

    @IBOutlet private var friendImageView: UIImageView!

    // MARK: - Public Method

    func update(friend: Friend) {
        friendImageView.image = UIImage(named: friend.imageName)
    }

    func update(news: News) {
        friendImageView.image = UIImage(named: news.postImageName.imageName)
    }
}
