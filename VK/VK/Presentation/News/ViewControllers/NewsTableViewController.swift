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
        static let unknownErrorText = "Unknown Error"
        static let decodingFailureText = "Decoding Failure"
        static let urlFailureText = "URL Failure"
        static let alertTitleText = "Внимание!"
        static let alertActionTitleText = "ok"
        static let loadingText = "Loading..."
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
    private var news: [NewsPost] = []
    private var isLoading = false
    private var nextPage: String?

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        fetchNews()
        setupRefreshControl()
    }

    // MARK: - Public Method

    override func numberOfSections(in tableView: UITableView) -> Int {
        news.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        NewsCellTypes.allCases.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        createCell(indexPath: indexPath)
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let news = news[indexPath.section]

        guard let cellType = NewsCellTypes(rawValue: indexPath.row),
              cellType == .content,
              news.attachments.first?.type == .photo,
              let photo = news.attachments.first?.photo
        else { return UITableView.automaticDimension }
        let tableWidth = UIScreen.main.bounds.width
        let height = (tableWidth / photo.aspectRation)
        return UITableView.automaticDimension
    }

    // MARK: - Private Method

    @objc private func refreshControlAction() {
        var mostFreshDate: TimeInterval?
        if let firstItem = news.first {
            mostFreshDate = firstItem.date + 1
            fetchNewNews(mostFreshDate: mostFreshDate)
        }
    }

    private func fetchNewNews(mostFreshDate: TimeInterval?) {
        networkService.fetchNewsPost(startTime: mostFreshDate) { [weak self] result in
            guard let self else { return }
            switch result {
            case let .success(response):
                self.refreshControl?.endRefreshing()
                self.news = response.newsPost + self.news
                self.tableView.reloadData()
            case .failure(.urlFailure):
                self.showAlert(
                    title: Constants.alertTitleText,
                    message: Constants.urlFailureText,
                    actionTitle: Constants.alertActionTitleText,
                    handler: nil
                )
            case .failure(.decodingFailure):
                self.showAlert(
                    title: Constants.alertTitleText,
                    message: Constants.decodingFailureText,
                    actionTitle: Constants.alertActionTitleText,
                    handler: nil
                )
            case .failure(.unknown):
                self.showAlert(
                    title: Constants.alertTitleText,
                    message: Constants.unknownErrorText,
                    actionTitle: Constants.alertActionTitleText,
                    handler: nil
                )
            }
        }
    }

    private func setupRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl?.tintColor = .black
        refreshControl?.attributedTitle = NSAttributedString(string: Constants.loadingText)
        refreshControl?.addTarget(self, action: #selector(refreshControlAction), for: .valueChanged)
    }

    private func fetchNews() {
        networkService.fetchNewsPost { [weak self] result in
            guard let self else { return }
            switch result {
            case let .success(response):
                self.news = response.newsPost
                self.nextPage = response.nextPage
                self.tableView.reloadData()
            case .failure(.urlFailure):
                self.showAlert(
                    title: Constants.alertTitleText,
                    message: Constants.urlFailureText,
                    actionTitle: Constants.alertActionTitleText,
                    handler: nil
                )
            case .failure(.decodingFailure):
                self.showAlert(
                    title: Constants.alertTitleText,
                    message: Constants.decodingFailureText,
                    actionTitle: Constants.alertActionTitleText,
                    handler: nil
                )
            case .failure(.unknown):
                self.showAlert(
                    title: Constants.alertTitleText,
                    message: Constants.unknownErrorText,
                    actionTitle: Constants.alertActionTitleText,
                    handler: nil
                )
            }
        }
    }

    private func configureTableView() {
        tableView.prefetchDataSource = self

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
        let news = news[indexPath.section]
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

    private func fetchNewsNextPage() {
        networkService.fetchNewsPost(startFrom: nextPage) { [weak self] result in
            guard let self else { return }
            switch result {
            case let .success(response):
                let oldNewsCount = self.news.count
                let newSections = (oldNewsCount ..< (oldNewsCount + response.newsPost.count)).map { $0 }
                self.news.append(contentsOf: response.newsPost)
                DispatchQueue.main.async {
                    self.tableView.insertSections(IndexSet(newSections), with: .automatic)
                }
                self.nextPage = response.nextPage
                self.isLoading = false
            case .failure(.urlFailure):
                self.showAlert(
                    title: Constants.alertTitleText,
                    message: Constants.urlFailureText,
                    actionTitle: Constants.alertActionTitleText,
                    handler: nil
                )
            case .failure(.decodingFailure):
                self.showAlert(
                    title: Constants.alertTitleText,
                    message: Constants.decodingFailureText,
                    actionTitle: Constants.alertActionTitleText,
                    handler: nil
                )
            case .failure(.unknown):
                self.showAlert(
                    title: Constants.alertTitleText,
                    message: Constants.unknownErrorText,
                    actionTitle: Constants.alertActionTitleText,
                    handler: nil
                )
            }
        }
    }
}

/// UITableViewDataSourcePrefetching
extension NewsTableViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard let maxRow = indexPaths.map(\.section).max(),
              maxRow > news.count - 3,
              isLoading == false
        else { return }
        isLoading = true
        fetchNewsNextPage()
    }
}
