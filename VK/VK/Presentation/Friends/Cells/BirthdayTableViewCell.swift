// BirthdayTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка дни рождения
final class BirthdayTableViewCell: UITableViewCell {
    // MARK: - Private Outlet

    @IBOutlet private var userImageView: UIImageView!
    @IBOutlet private var userNameLabel: UILabel!

    // MARK: - Public Methods

    func update(birthdays: Birthday) {
        userImageView.image = UIImage(named: birthdays.imageName)
        userNameLabel.text = birthdays.name
    }
}
