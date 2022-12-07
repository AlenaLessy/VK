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
        static let headerCellIdentifier = "Header"
        static let footerCellIdentifier = "Footer"
        static let postAndImageCellIdentifier = "PostAndImageTableViewCell"
        static let postCellIdentifier = "PostTableViewCell"
        static let imageCellIdentifier = "ImageTableViewCell"
        static let headerNibName = "HeaderTableViewCell"
        static let footerNibName = "FooterTableViewCell"
        static let unknownError = "Unknown Error"
        static let decodingFailure = "Decoding Failure"
        static let urlFailure = "URL Failure"
    }

    // MARK: - Types

    private enum NewsCellTypes: Int, CaseIterable {
        case header
        case content
        case footer
    }

    // MARK: - Private Properties

    private let networkService = NetworkService()

    private var currentIndex = 0
    private var newsPost: ItemsNewsResponse?

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        getNews()
    }

    // MARK: - Public Method

    override func numberOfSections(in tableView: UITableView) -> Int {
        guard let count = newsPost?.postNews.count else { return 0 }
        return count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        NewsCellTypes.allCases.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        createCell(indexPath: indexPath)
    }

    // MARK: - Private Method

    private func getNews() {
        networkService.fetchNewsPost { [weak self] result in
            guard let self else { return }
            switch result {
            case let .success(response):
                self.newsFiltered(response)
            case .failure(.urlFailure):
                print(Constants.urlFailure)
            case .failure(.decodingFailure):
                print(Constants.decodingFailure)
            case .failure(.unknown):
                print(Constants.unknownError)
            }
        }
    }

    private func newsFiltered(_ news: ItemsNewsResponse) {
        var news = news
        news.postNews = news.postNews.filter { $0.attachments.contains(where: { $0.type == .photo }) }
        news.postNews.forEach { item in
            if item.sourceId < 0 {
                guard let group = news.groupsInfo.filter({ group in
                    group.id == item.sourceId * -1
                }).first else { return }
                item.name = group.name
                item.photoUrlName = group.photo
            } else {
                guard let friend = news.profilesInfo.filter({ friend in
                    friend.id == item.sourceId
                }).first else { return }
                item.name = friend.firstName + " " + friend.lastName
                item.photoUrlName = friend.imageName
            }
        }
        DispatchQueue.main.async {
            self.newsPost = news
            self.tableView.reloadData()
        }
    }

    private func configureTableView() {
        tableView.register(
            UINib(nibName: Constants.newsNibName, bundle: nil),
            forCellReuseIdentifier: Constants.newsIdentifier
        )
        tableView.register(
            UINib(nibName: Constants.headerNibName, bundle: nil),
            forCellReuseIdentifier: Constants.headerCellIdentifier
        )
        tableView.register(
            UINib(nibName: Constants.footerNibName, bundle: nil),
            forCellReuseIdentifier: Constants.footerCellIdentifier
        )
        tableView.register(
            UINib(nibName: Constants.imageCellIdentifier, bundle: nil),
            forCellReuseIdentifier: Constants.imageCellIdentifier
        )
        tableView.register(
            UINib(nibName: Constants.postCellIdentifier, bundle: nil),
            forCellReuseIdentifier: Constants.postCellIdentifier
        )
        tableView.register(
            UINib(nibName: Constants.postAndImageCellIdentifier, bundle: nil),
            forCellReuseIdentifier: Constants.postAndImageCellIdentifier
        )
    }

    private func createCell(indexPath: IndexPath) -> UITableViewCell {
        guard let news = newsPost?.postNews[indexPath.section] else { return UITableViewCell() }
        let cellType = NewsCellTypes(rawValue: indexPath.row) ?? .header
        var cellIdentifier = ""

        switch cellType {
        case .header:
            cellIdentifier = Constants.headerCellIdentifier
        case .content:
            // swiftlint: disable all
            if news.attachments.first?.type == .photo,
               !news.post.isEmpty
            {
                cellIdentifier = Constants.postAndImageCellIdentifier
            } else if !news.post.isEmpty,
                      news.attachments.first?.type != .photo
            {
                cellIdentifier = Constants.postCellIdentifier
            } else if news.attachments.first?.type == .photo,
                      news.post.isEmpty
            {
                cellIdentifier = Constants.imageCellIdentifier
            }
        case .footer:
            cellIdentifier = Constants.footerCellIdentifier
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? NewsCell
        else { return UITableViewCell() }
        cell.update(news: news, networkService: networkService)
        return cell
    }
}
