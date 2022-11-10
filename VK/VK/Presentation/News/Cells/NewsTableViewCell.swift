//
//  NewsTableViewCell.swift
//  VK
//
//  Created by Алена Панченко on 09.11.2022.
//

import UIKit

/// Ячейка новостей
final class NewsTableViewCell: UITableViewCell {
    // MARK: - Public Outlets

    @IBOutlet var collectionView: UICollectionView!

    // MARK: - Private Outlets

    @IBOutlet private var userImageView: UIImageView!
    @IBOutlet private var userNameLabel: UILabel!
    @IBOutlet private var dateLabel: UILabel!
    @IBOutlet private var postLabel: UILabel!

    // MARK: - Public Methods

    func update(news: News) {
        userImageView.image = UIImage(named: news.userImageName)
        userNameLabel.text = news.userName
        postLabel.text = news.post
        dateLabel.text = news.date
    }
}
