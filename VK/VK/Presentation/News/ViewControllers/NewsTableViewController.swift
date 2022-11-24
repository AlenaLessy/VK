// NewsTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран новостей
final class NewsTableViewController: UITableViewController {
    // MARK: - Private Constants

    private enum Constants {
        static let newsIdentifier = "News"
        static let newsNibName = "NewsTableViewCell"
        static let friendIdentifier = "Friend"
        static let friendNibName = "FriendCollectionViewCell"
    }

    // MARK: - Private Properties

    private var currentIndex = 0

    private var newsDataCourse: [News] = News.newsDataCourse()

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }

    // MARK: - Public Method

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        newsDataCourse.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        createCell(indexPath: indexPath)
    }

    // MARK: - Private Method

    private func configureTableView() {
        tableView.register(
            UINib(nibName: Constants.newsNibName, bundle: nil),
            forCellReuseIdentifier: Constants.newsIdentifier
        )
    }

    private func createCell(indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.newsIdentifier,
            for: indexPath
        ) as? NewsTableViewCell else { return UITableViewCell() }
        let news = newsDataCourse[indexPath.row]
        currentIndex = indexPath.row
        cell.update(news: news)
        cell.collectionView.dataSource = self
        cell.collectionView.delegate = self
        cell.collectionView.register(
            UINib(nibName: Constants.friendNibName, bundle: nil),
            forCellWithReuseIdentifier: Constants.friendIdentifier
        )
        return cell
    }

    private func collectionViewCellHeight(indexPath: IndexPath) -> CGFloat {
        guard indexPath.row < newsDataCourse.count else { return 0 }
        let numberImages = newsDataCourse[indexPath.row].postImageName.imageNames.count
        switch numberImages {
        case 1:
            return view.bounds.width
        default:
            return (view.bounds.width / 2) * CGFloat(lroundf(Float(numberImages) / 2))
        }
    }
}

/// UICollectionViewDataSource
extension NewsTableViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Constants.friendIdentifier,
            for: indexPath
        ) as? FriendCollectionViewCell
        else { return UICollectionViewCell() }
        cell.cellHeightLayoutConstraint.constant = collectionViewCellHeight(indexPath: indexPath)
        let news = newsDataCourse[currentIndex]
        cell.update(news: news)
        return cell
    }
}

/// UICollectionViewDelegateFlowLayout
extension NewsTableViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let side = UIScreen.main.bounds.width
        return CGSize(width: side, height: side)
    }
}
