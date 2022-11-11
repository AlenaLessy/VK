//
//  FriendsTableViewCell.swift
//  VK
//
//  Created by Алена Панченко on 05.11.2022.
//

import UIKit

/// Ячейка друзей
final class FriendsTableViewCell: UITableViewCell {
    // MARK: - Private Constants

    private enum Constants {
        static let emptyString = ""
        static let commaString = ", "
    }

    // MARK: - Private Outlet

    @IBOutlet private var userImageView: UIImageView!
    @IBOutlet private var userNameLabel: UILabel!
    @IBOutlet private var userInfoLabel: UILabel!

    // MARK: - LifeCycle

    override func awakeFromNib() {
        super.awakeFromNib()
        addTapGesture()
    }

    // MARK: - Public Methods

    func update(friend: Friend) {
        guard let imageName = friend.imageNames.first else { return }
        userImageView.image = UIImage(named: imageName)
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

    // MARK: - Private Methods

    @objc private func gestureRecognizerAction() {
        UIView.animate(withDuration: 0.4, delay: 0) {
            self.userImageView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }
        userImageView.transform = .identity
    }

    private func addTapGesture() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(gestureRecognizerAction))
        userImageView.addGestureRecognizer(tapGestureRecognizer)
        userImageView.isUserInteractionEnabled = true
    }
}
