// GroupTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка групп пользователя
final class GroupTableViewCell: UITableViewCell {
    // MARK: - Private Outlet

    @IBOutlet private var groupImageView: UIImageView!
    @IBOutlet private var groupNameLabel: UILabel!

    // MARK: - Public Method

    func update(group: Group) {
        groupImageView.image = UIImage(named: group.groupImageName)
        groupNameLabel.text = group.groupName
    }
}
