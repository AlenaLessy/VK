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

    // MARK: - Public Properties

    func update(friends: Friends) {
        userImageView.image = UIImage(named: friends.imageName)
        userNameLabel.text = friends.name
        if friends.city != nil, friends.age?.description != nil {
            userInfoLabel.text = (friends.age?.description ?? Constants.emptyString) + Constants
                .commaString + (friends.city ?? Constants.emptyString)
        } else if friends.city != nil {
            userInfoLabel.text = friends.city
        } else if friends.age?.description != nil {
            userInfoLabel.text = friends.age?.description
        }
    }
}
