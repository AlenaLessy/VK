// ImageTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка поста с фотографией
final class ImageTableViewCell: UITableViewCell, NewsConfigurable {
    // MARK: - Private Constants

    private enum Constants {
        static let friendPhotosIdentifier = "FriendPhotosCollectionViewCell"
        static let friendPhotosNibName = "FriendPhotosCollectionViewCell"
    }

    // MARK: - Private Outlets

    @IBOutlet private var collectionView: UICollectionView!

    // MARK: - Private Properties

    private let networkService = NetworkService()
    
    private var newsDataSource: NewsPost?

    // MARK: - Life Cycle

    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
    }

    // MARK: - Public Method
    
    override func prepareForReuse() {
        super.prepareForReuse()
        newsDataSource = nil
        collectionView.reloadData()
    }
    
    func update(news: NewsPost, networkService: NetworkService?) {
        newsDataSource = news
    }

    // MARK: - Private Method

    private func setupCollectionView() {
        collectionView.register(
            UINib(nibName: Constants.friendPhotosNibName, bundle: nil),
            forCellWithReuseIdentifier: Constants.friendPhotosIdentifier
        )
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

/// UICollectionViewDataSource
extension ImageTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Constants.friendPhotosIdentifier,
            for: indexPath
        ) as? FriendPhotosCollectionViewCell
        else { return UICollectionViewCell() }
        // cell.cellHeightLayoutConstraint.constant = collectionViewCellHeight(indexPath: indexPath)
        guard let newsDataSource else { return UICollectionViewCell() }
        cell.update(news: newsDataSource, networkService: networkService)
        return cell
    }
}

/// UICollectionViewDelegateFlowLayout
extension ImageTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let side = UIScreen.main.bounds.width
        return CGSize(width: side, height: side)
    }
}
