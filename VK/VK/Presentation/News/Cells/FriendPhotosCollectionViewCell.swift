// FriendPhotosCollectionViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка коллекции друзей
final class FriendPhotosCollectionViewCell: UICollectionViewCell {
    // MARK: - Public Outlets

    @IBOutlet var cellHeightLayoutConstraint: NSLayoutConstraint!

    // MARK: - Private Outlets

    @IBOutlet private var friendImageView: UIImageView!

    // MARK: - Public Method

    override func prepareForReuse() {
        super.prepareForReuse()
        friendImageView.image = nil
    }

    func update(news: NewsPost, networkService: NetworkService) {
        guard let photos = news.attachments.first?.photo?.url else { return }
        friendImageView.loadImage(imageURL: photos, networkService: networkService)
    }
}
