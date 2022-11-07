//
//  FriendsTableViewController.swift
//  VK
//
//  Created by Алена Панченко on 05.11.2022.
//

import UIKit

// Экран друзей
final class FriendsTableViewController: UITableViewController {
    // MARK: - Constants

    private enum Constants {
        static let friendsSearchIdentifier = "FriendsSearch"
        static let friendsSearchNibName = "FriendsSearchTableViewCell"
        static let friendsInfoIdentifier = "FriendsInfo"
        static let friendsInfoNibName = "FriendsInfoTableViewCell"
        static let friendsRequestIdentifier = "FriendsRequest"
        static let friendsRequestNibName = "FriendsRequestTableViewCell"
        static let birthdayIdentifier = "Birthday"
        static let birthdayNibName = "BirthdayTableViewCell"
        static let friendsIdentifier = "Friends"
        static let friendsNibName = "FriendsTableViewCell"
        static let birthdaySectionName = "Дни рождения"
        static let friendsSectionName = "Друзья"
    }

    private enum SectionType {
        case friendsSearch
        case friendsInfo
        case friendsRequest
        case birthday
        case friends
    }

    // MARK: - Private Properties

    private var sections: [SectionType] = [.friendsSearch, .friendsInfo, .friendsRequest, .birthday, .friends]

    private var birthdaysDataSource: [Birthdays] = [
        Birthdays(name: "Михалыч", imageName: "mi5"),
        Birthdays(name: "Потапка", imageName: "mi6"),
        Birthdays(name: "Евгений Медведев", imageName: "mi7"),
        Birthdays(name: "Топтышка Мишулин", imageName: "mi8")
    ]

    private var friendsDataSource: [Friends] = [
        Friends(name: "Михаил Потапыч", imageName: "m1", city: "Сочи"),
        Friends(name: "Медведь Бурый", imageName: "m2", age: 14, city: "Питер"),
        Friends(name: "Мишка Белый", imageName: "mi1", age: 19, city: "Севастополь"),
        Friends(name: "Коала Пропала", imageName: "m3"),
        Friends(name: "Гризли Загрызли", imageName: "m4", age: 42),
        Friends(name: "Миша Цирковой", imageName: "m5", age: 5, city: "Ростов"),
    ]

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }

    // MARK: - Private Method

    private func configureTableView() {
        tableView.register(
            UINib(nibName: Constants.friendsSearchNibName, bundle: nil),
            forCellReuseIdentifier: Constants.friendsSearchIdentifier
        )
        tableView.register(
            UINib(nibName: Constants.friendsInfoNibName, bundle: nil),
            forCellReuseIdentifier: Constants.friendsInfoIdentifier
        )
        tableView.register(
            UINib(nibName: Constants.friendsRequestNibName, bundle: nil),
            forCellReuseIdentifier: Constants.friendsRequestIdentifier
        )
        tableView.register(
            UINib(nibName: Constants.birthdayNibName, bundle: nil),
            forCellReuseIdentifier: Constants.birthdayIdentifier
        )
        tableView.register(
            UINib(nibName: Constants.friendsNibName, bundle: nil),
            forCellReuseIdentifier: Constants.friendsIdentifier
        )
    }

    private func createCell(indexPath: IndexPath) -> UITableViewCell {
        let section = sections[indexPath.section]
        switch section {
        case .friendsSearch:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: Constants.friendsSearchIdentifier,
                for: indexPath
            ) as? FriendsSearchTableViewCell else { return UITableViewCell() }
            return cell
        case .friendsInfo:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: Constants.friendsInfoIdentifier,
                for: indexPath
            ) as? FriendsInfoTableViewCell else { return UITableViewCell() }
            return cell
        case .friendsRequest:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: Constants.friendsRequestIdentifier,
                for: indexPath
            ) as? FriendsRequestTableViewCell else { return UITableViewCell() }
            return cell
        case .birthday:
            let model = birthdaysDataSource[indexPath.row]
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: Constants.birthdayIdentifier,
                for: indexPath
            ) as? BirthdayTableViewCell else { return UITableViewCell() }
            cell.update(birthdays: model)
            return cell
        case .friends:
            let model = friendsDataSource[indexPath.row]
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: Constants.friendsIdentifier,
                for: indexPath
            ) as? FriendsTableViewCell else { return UITableViewCell() }
            cell.update(friends: model)
            return cell
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let type = sections[section]
        switch type {
        case .friendsSearch, .friendsInfo, .friendsRequest:
            return 1
        case .birthday:
            return birthdaysDataSource.count
        case .friends:
            return friendsDataSource.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        createCell(indexPath: indexPath)
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let type = sections[section]
        switch type {
        case .friendsSearch, .friendsInfo, .friendsRequest:
            return nil
        case .birthday:
            return Constants.birthdaySectionName
        case .friends:
            return Constants.friendsSectionName
        }
    }

    // MARK: - Table view delegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 300, height: 300)
        let profileCollectionViewController = ProfileCollectionViewController(collectionViewLayout: layout)
        profileCollectionViewController.friend = friendsDataSource[indexPath.row]
        navigationController?.pushViewController(profileCollectionViewController, animated: true)
    }
}
