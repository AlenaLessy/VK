// GroupTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка групп пользователя
final class GroupTableViewCell: UITableViewCell {
    // MARK: - Private Outlet

    @IBOutlet private var groupImageView: UIImageView!
    @IBOutlet private var groupNameLabel: UILabel!

    // MARK: - Public Method

    override func prepareForReuse() {
        super.prepareForReuse()
        groupImageView.image = UIImage(named: "mi2")
    }

    func configure(group: Group, photoService: PhotoService) {
        groupImageView.image = photoService.photo(byUrl: group.photo)
        groupNameLabel.text = group.name
    }
}
