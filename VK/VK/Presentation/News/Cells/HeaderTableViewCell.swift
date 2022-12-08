// HeaderTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Хэдер новости
final class HeaderTableViewCell: UITableViewCell, NewsConfigurable {
    // MARK: - Private Outlets

    @IBOutlet private var userImageView: UIImageView!
    @IBOutlet private var userNameLabel: UILabel!
    @IBOutlet private var dateLabel: UILabel!

    // MARK: - Public Methods

    func update(news: NewsPost, networkService: NetworkService) {
        userNameLabel.text = news.name
        guard let photoURL = news.photoUrlName else { return }
        userImageView.loadImage(imageURL: photoURL, networkService: networkService)
    }
}
