//
//  BirthdayTableViewCell.swift
//  VK
//
//  Created by Алена Панченко on 05.11.2022.
//

import UIKit

/// Ячейка дни рождения
final class BirthdayTableViewCell: UITableViewCell {
    // MARK: - Private Outlet

    @IBOutlet private var userImageView: UIImageView!
    @IBOutlet private var userNameLabel: UILabel!

    // MARK: - Public Properties

    func update(birthdays: Birthdays) {
        userImageView.image = UIImage(named: birthdays.imageName)
        userNameLabel.text = birthdays.name
    }
}
