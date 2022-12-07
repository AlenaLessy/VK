// PostTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка текстового поста
final class PostTableViewCell: UITableViewCell, NewsConfigurable {
    // MARK: - Private Outlets

    @IBOutlet private var textView: UITextView!

    // MARK: - Public Methods

    func update(news: NewsPost) {
        textView.text = news.post
    }
}
