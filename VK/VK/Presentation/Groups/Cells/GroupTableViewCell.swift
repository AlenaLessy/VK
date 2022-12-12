// GroupTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка групп пользователя
final class GroupTableViewCell: UITableViewCell {
    // MARK: - Private Outlet

    @IBOutlet private var groupImageView: UIImageView!
    @IBOutlet private var groupNameLabel: UILabel!

    // MARK: - Public Method

    func configure(group: Group, indexPath: IndexPath, photoService: PhotoService) {
        groupImageView.image = photoService.photo(atIndexpath: indexPath, byUrl: group.photo)
        groupNameLabel.text = group.name
    }
}
