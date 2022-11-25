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

    var friend: NewsFriends?

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

    // MARK: - Public Method

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: Constants.FriendCellIdentifier,
                for: indexPath
            ) as? FriendCollectionViewCell,
            let model = friend else { return UICollectionViewCell() }
        cell.update(friend: model)
        return cell
    }

    // MARK: - Private Methods

    private func cellRegister() {
        collectionView.register(
            UINib(nibName: Constants.FriendCellNibName, bundle: nil),
            forCellWithReuseIdentifier: Constants.FriendCellIdentifier
        )
    }
}
