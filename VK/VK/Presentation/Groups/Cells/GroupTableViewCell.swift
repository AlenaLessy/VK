// GroupTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка групп пользователя
final class GroupTableViewCell: UITableViewCell {
    // MARK: - Private Outlet

    @IBOutlet private var groupImageView: UIImageView!
    @IBOutlet private var groupNameLabel: UILabel!

    // MARK: - Public Method

    func configure(group: Group, networkService: NetworkService) {
        groupImageView.loadImage(imageURL: group.photo, networkService: networkService)
        groupNameLabel.text = group.name
    }
}
