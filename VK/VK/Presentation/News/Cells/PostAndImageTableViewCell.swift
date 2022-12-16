// PostAndImageTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка поста с фотографией и текстом
final class PostAndImageTableViewCell: UITableViewCell, NewsConfigurable {
    // MARK: - Private Constants

    private enum Constants {
        static let friendPhotosIdentifier = "FriendPhotosCollectionViewCell"
        static let friendPhotosNibName = "FriendPhotosCollectionViewCell"
    }

    // MARK: - Private Outlets

    @IBOutlet private var collectionView: UICollectionView!
    @IBOutlet private var textView: UITextView!

    // MARK: - Private Properties

    private var networkService: NetworkService?
    private var newsDataSource: NewsPost?

    // MARK: - Life Cycle

    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
    }

    // MARK: - Public Method

    override func prepareForReuse() {
        super.prepareForReuse()
        textView.text = nil
        newsDataSource = nil
        collectionView.reloadData()
    }

    func update(news: NewsPost, networkService: NetworkService) {
        newsDataSource = news
        textView.text = news.post
        self.networkService = networkService
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
extension PostAndImageTableViewCell: UICollectionViewDataSource {
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
        ) as? FriendPhotosCollectionViewCell,
            let newsDataSource,
            let networkService
        else { return UICollectionViewCell() }

        cell.update(news: newsDataSource, networkService: networkService)
        return cell
    }
}

/// UICollectionViewDelegateFlowLayout
extension PostAndImageTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let side = UIScreen.main.bounds.width
        guard let height = newsDataSource?.attachments.first?.photo?.aspectRation

        else { return CGSize(width: 0, height: 0) }

        let result = side / height

        return CGSize(width: side, height: result)
    }
}
