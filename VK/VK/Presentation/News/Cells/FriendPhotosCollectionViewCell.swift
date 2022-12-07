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

//    func update(friend: FriendNews) {
//        guard let imageName = friend.imageNames.first else { return }
//        friendImageView.image = UIImage(named: imageName)
//    }

    func update(news: NewsPost) {
        guard let photos = news.attachments.first?.photo?.url else { return }
        let networkService = NetworkService()
//        for value in photos {
//            guard let name = value?.url else { return }
        friendImageView.loadImage(imageURL: photos, networkService: networkService)
    }

//        let photos = response.postNews.reduce([NewsPhoto]()) {
//            $0 + $1.attachments.compactMap(\.photo)
//        }
//        guard let imageName = news.postImageName?.imageNames.first else { return }
//        friendImageView.image = UIImage(named: imageName)
}
