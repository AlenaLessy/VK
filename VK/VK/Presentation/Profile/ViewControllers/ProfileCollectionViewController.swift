// ProfileCollectionViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Коллекция изображений друзей
final class ProfileCollectionViewController: UICollectionViewController {
    // MARK: - Private Constants

    private enum Constants {
        static let FriendCellIdentifier = "Friend"
        static let FriendCellNibName = "FriendCollectionViewCell"
    }

    // MARK: - Public Properties

    var friend: FriendNews?

    // MARK: - Initializers

    override init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(collectionViewLayout: layout)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        cellRegister()
    }

    // MARK: - Private Methods

    private func cellRegister() {
        collectionView.register(
            UINib(nibName: Constants.FriendCellNibName, bundle: nil),
            forCellWithReuseIdentifier: Constants.FriendCellIdentifier
        )
    }
}
