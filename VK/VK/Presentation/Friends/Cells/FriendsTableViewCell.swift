//
//  FriendsTableViewCell.swift
//  VK
//
//  Created by Алена Панченко on 05.11.2022.
//

import UIKit

/// Ячейка друзей
final class FriendsTableViewCell: UITableViewCell {
    // MARK: - Constants

    private enum Constants {
        static let emptyString = ""
        static let commaString = ", "
    }

    // MARK: - Private Outlet

    @IBOutlet private var userImageView: UIImageView!
    @IBOutlet private var userNameLabel: UILabel!
    @IBOutlet private var userInfoLabel: UILabel!

    // MARK: - Public Methods

    func update(friend: Friend) {
        userImageView.image = UIImage(named: friend.imageName)
        userNameLabel.text = friend.name
        if friend.city != nil, friend.age?.description != nil {
            userInfoLabel.text = (friend.age?.description ?? Constants.emptyString) + Constants
                .commaString + (friend.city ?? Constants.emptyString)
        } else if friend.city != nil {
            userInfoLabel.text = friend.city
        } else if friend.age?.description != nil {
            userInfoLabel.text = friend.age?.description
        }
    }
}
