//
//  NewsTableViewController.swift
//  VK
//
//  Created by Алена Панченко on 09.11.2022.
//

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

    private var newsDataCourse: [News] = [
        News(
            userImageName: "mi1",
            userName: "Потап Михалыч",
            date: "12.05.2022",
            post: "Все виды медведей невероятно умны. Эти животные очень любознательны",
            postImageName: Friend(name: "Потап Михалыч", imageName: "mi1")
        ),
        News(
            userImageName: "mi2",
            userName: "Топотун Бурый",
            date: "13.05.2022",
            post: "Самый крупный медведь - полярный. Вес взрослого самца доходит до 500 кг.",
            postImageName: Friend(name: "Топотун Бурый", imageName: "m2")
        ),
        News(
            userImageName: "mi3",
            userName: "Медведь Гризли",
            date: "14.05.2022",
            post: """
            У всех медведей два слоя шерсти. \
            Один слой легкий и пушистый для тепла, второй тяжелый и непромокаемый
            """,
            postImageName: Friend(name: "Медведь Гризли", imageName: "m3")
        ),
        News(
            userImageName: "mi4",
            userName: "Белый Медвежуля",
            date: "15.05.2022",
            post: "Медведей принято считать косолапыми, но это совсем не так.",
            postImageName: Friend(name: "Белый Медвежуля", imageName: "m4")
        ),
    ]

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
        let model = newsDataCourse[indexPath.row]
        currentIndex = indexPath.row
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.newsIdentifier,
            for: indexPath
        ) as? NewsTableViewCell else { return UITableViewCell() }
        cell.update(news: model)
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
        let numberImages = newsDataCourse[indexPath.row].postImageName.imageName.count
        switch numberImages {
        case 1:
            return view.bounds.width
        default: return (view.bounds.width / 2) * CGFloat(lroundf(Float(numberImages) / 2))
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
        let model = newsDataCourse[currentIndex]
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Constants.friendIdentifier,
            for: indexPath
        ) as? FriendCollectionViewCell
        else { return UICollectionViewCell() }
        cell.cellHeightLayoutConstraint.constant = collectionViewCellHeight(indexPath: indexPath)
        cell.update(news: model)
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
