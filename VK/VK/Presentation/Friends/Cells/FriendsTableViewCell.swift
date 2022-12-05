// FriendsTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

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

    // MARK: - LifeCycle

    override func awakeFromNib() {
        super.awakeFromNib()
        addTapGesture()
    }

    // MARK: - Public Methods

    func update(friend: Friend, networkService: NetworkService) {
        userImageView.loadImage(imageURL: friend.imageName, networkService: networkService)
        userNameLabel.text = friend.firstName + " " + friend.lastName
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
