// FooterTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Футер новости
class FooterTableViewCell: UITableViewCell, NewsConfigurable {
    // MARK: - Private Outlets

    @IBOutlet private var numberOfLikesLabel: UILabel!
    @IBOutlet private var numberOfCommentsLabel: UILabel!
    @IBOutlet private var numberOfRepostsLabel: UILabel!
    @IBOutlet private var numberOfViewsLabel: UILabel!

    // MARK: - Public Methods

    func update(news: NewsPost) {
//        numberOfLikesLabel.text = String(news.likesCount)
//        numberOfCommentsLabel.text = String(news.commentsCount)
//        numberOfRepostsLabel.text = String(news.repostsCount)
//        numberOfViewsLabel.text = String(news.viewsCount)
    }
}
