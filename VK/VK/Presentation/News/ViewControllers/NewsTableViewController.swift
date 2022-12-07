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

    // MARK: - Types

    private enum NewsCellTypes: Int, CaseIterable {
        case header
        case content
        case footer
    }

    // MARK: - Private Properties

    private var currentIndex = 0

    private var news: [News] = News.createNews()
    private var newsPost: ItemsNewsResponse?
    private let networkService = NetworkService()

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        fetchNews()
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

    private func fetchNews() {
        networkService.fetchNewsPost { [weak self] result in
            guard let self else { return }
            switch result {
            case let .success(response):
                //   self.newsPost = response
//                print("test \(self.newsPost)")
//
//                let photos = self.newsPost.reduce([NewsPhoto]()) {
//                    $0 + $1.attachments.compactMap(\.photo)
                let photos = response.postNews.reduce([NewsPhoto]()) {
                    $0 + $1.attachments.compactMap(\.photo)
                }
                print("test \(photos)")
                self.createNews(response)
                self.tableView.reloadData()
            case .failure(.urlFailure):
                print("urlFailure")
            case .failure(.decodingFailure):
                print("decodingFailure")
            case .failure(.unknown):
                print("unknown")
            }
        }
    }

    private func createNews(_ news: ItemsNewsResponse) {
        news.postNews.forEach { item in
            if item.sourceId < 0 {
                guard let group = news.groupsInfo.filter({ group in
                    group.id == item.sourceId * -1
                }).first else { return }
                item.name = group.name
                item.photoUrl = group.photo
            } else {
                guard let friend = news.profilesInfo.filter({ friend in
                    friend.id == item.sourceId
                }).first else { return }
                item.name = friend.firstName + " " + friend.lastName
                item.photoUrl = friend.imageName
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
            UINib(nibName: "HeaderTableViewCell", bundle: nil),
            forCellReuseIdentifier: "Header"
        )
        tableView.register(
            UINib(nibName: "FooterTableViewCell", bundle: nil),
            forCellReuseIdentifier: "Footer"
        )
        tableView.register(
            UINib(nibName: "ImageTableViewCell", bundle: nil),
            forCellReuseIdentifier: "ImageTableViewCell"
        )
        tableView.register(
            UINib(nibName: "PostTableViewCell", bundle: nil),
            forCellReuseIdentifier: "PostTableViewCell"
        )
        tableView.register(
            UINib(nibName: "PostAndImageTableViewCell", bundle: nil),
            forCellReuseIdentifier: "PostAndImageTableViewCell"
        )
    }

//    private func createCell(indexPath: IndexPath) -> UITableViewCell {
//        let news = news[indexPath.section]
//        let cellType = NewsCellTypes(rawValue: indexPath.row) ?? .header
//        var cellIdentifier = ""
//
//        switch cellType {
//        case .header:
//            cellIdentifier = "Header"
//        case .content:
//            cellIdentifier = designationContentCellIdentifier(newsCellType: news)
//        case .footer:
//            cellIdentifier = "Footer"
//        }
//
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? NewsCell
//        else { return UITableViewCell() }
//        cell.update(news: news)
//        return cell
//    }

//    private func designationContentCellIdentifier(newsCellType: News) -> String {
//        switch newsCellType.postType {
//        case .image:
//            return "ImageTableViewCell"
//        case .post:
//            return "PostTableViewCell"
//        case .imageAndPost:
//            return "PostAndImageTableViewCell"
//        }
//    }
    // }

    private func createCell(indexPath: IndexPath) -> UITableViewCell {
        guard let news = newsPost?.postNews[indexPath.section] else { return UITableViewCell() }
        let cellType = NewsCellTypes(rawValue: indexPath.row) ?? .header
        var cellIdentifier = ""

        switch cellType {
        case .header:
            cellIdentifier = "Header"
        case .content:
            cellIdentifier = "PostAndImageTableViewCell"
        case .footer:
            cellIdentifier = "Footer"
        }

        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? NewsCell
        else { return UITableViewCell() }
        cell.update(news: news)
        return cell
    }

//    private func designationContentCellIdentifier(newsCellType: NewsPost) -> String {
//        switch newsCellType.postType {
//        case .image:
//            return "ImageTableViewCell"
//        case .post:
//            return "PostTableViewCell"
//        case .imageAndPost:
//            return "PostAndImageTableViewCell"
//        }
//    }
}
