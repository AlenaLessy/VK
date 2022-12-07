// FooterTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Футер новости
final class FooterTableViewCell: UITableViewCell, NewsConfigurable {
    // MARK: - Private Outlets

    @IBOutlet private var numberOfLikesLabel: UILabel!
    @IBOutlet private var numberOfCommentsLabel: UILabel!
    @IBOutlet private var numberOfRepostsLabel: UILabel!
    @IBOutlet private var numberOfViewsLabel: UILabel!

    // MARK: - Public Methods

    func update(news: NewsPost, networkService: NetworkService) {}
}
