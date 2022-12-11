// FriendsTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// Экран друзей
final class FriendsTableViewController: UITableViewController {
    // MARK: - Private Constants

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
        static let headerIdentifier = "Header"
        static let headerNibName = "HeaderView"
        static let storyBoardName = "Main"
        static let profileVCIdentifier = "ProfileVC"
        static let unknownFailureName = "Неизвестная ошибка"
        static let decodingFailureName = "Ошибка декодирования"
        static let urlFailureName = "Ошибка URL"
    }

    private enum SectionType {
        case friendsSearch
        case friendsInfo
        case friendsRequest
        case birthday
        case friends(String)
    }

    // MARK: - Private Properties

    private let promiseProvider = PromiseProvider()
    private let networkService = NetworkService()
    private var friendSectionsMap: [Character: [Friend]] = [:]
    private var sectionTitles: [Character] = []
    private var generalSectionsCount = 4
    private var sections: [SectionType] = [.friendsSearch, .friendsInfo, .friendsRequest, .birthday]

    private var birthdays: [Birthday] = [
        Birthday(name: "Михалыч", imageName: "mi5"),
        Birthday(name: "Потапка", imageName: "mi6"),
        Birthday(name: "Евгений Медведев", imageName: "mi7"),
        Birthday(name: "Топтышка Мишулин", imageName: "mi8")
    ]

    private var friends: [Friend] = []

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        getFriends()
        observe()
    }

    // MARK: - Public Method

    override func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        setupNumberOfRows(section: section)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        createCell(indexPath: indexPath)
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        setupTableViewSelect(indexPath: indexPath)
    }

    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        sectionTitles.map { String($0) }
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        headerConfigure(section: section)
    }

    // MARK: - Private Method

    private func observe() {
        promiseProvider.observeFriends { [weak self] friends in
            guard let self else { return }
            self.friends = friends
            self.createSections()
            self.tableView.reloadData()
        }
    }

    private func getFriends() {
        promiseProvider.fetchFriends()
    }

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

        tableView.register(
            UINib(nibName: Constants.headerNibName, bundle: nil),
            forHeaderFooterViewReuseIdentifier: Constants.headerIdentifier
        )
    }

    private func headerConfigure(section: Int) -> UIView? {
        let type = sections[section]
        switch type {
        case .friendsSearch, .friendsInfo, .friendsRequest:
            return nil
        case .birthday:
            guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: Constants.headerIdentifier)
                as? HeaderView else { return UITableViewHeaderFooterView() }
            header.titleLabel.text = Constants.birthdaySectionName
            return header
        case .friends:
            guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: Constants.headerIdentifier)
                as? HeaderView else { return UITableViewHeaderFooterView() }
            let title = String(sectionTitles[section - generalSectionsCount])
            header.titleLabel.text = title
            return header
        }
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
            let model = birthdays[indexPath.row]
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: Constants.birthdayIdentifier,
                for: indexPath
            ) as? BirthdayTableViewCell else { return UITableViewCell() }
            cell.update(birthdays: model)
            return cell
        case .friends:
            guard let friend =
                friendSectionsMap[sectionTitles[indexPath.section - generalSectionsCount]]?[indexPath.row],
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: Constants.friendsIdentifier,
                    for: indexPath
                ) as? FriendsTableViewCell else { return UITableViewCell() }
            cell.update(friend: friend, networkService: networkService)
            print(friend)
            return cell
        }
    }

    private func setupNumberOfRows(section: Int) -> Int {
        let type = sections[section]
        switch type {
        case .friendsSearch, .friendsInfo, .friendsRequest:
            return 1
        case .birthday:
            return birthdays.count
        case .friends:
            return friendSectionsMap[sectionTitles[section - generalSectionsCount]]?.count ?? 0
        }
    }

    private func setupTableViewSelect(indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: Constants.storyBoardName, bundle: nil)
        guard let profileViewController = storyBoard
            .instantiateViewController(withIdentifier: Constants.profileVCIdentifier) as? ProfileViewController
        else { return }
        profileViewController.userId = friends[indexPath.row].id
        present(profileViewController, animated: true)
    }

    private func createSections() {
        for friend in friends {
            guard let firstLetter = friend.firstName.first else { return }
            if friendSectionsMap[firstLetter] != nil {
                friendSectionsMap[firstLetter]?.append(friend)
            } else {
                friendSectionsMap[firstLetter] = [friend]
                sections.append(.friends(String(firstLetter)))
            }
            sectionTitles = Array(friendSectionsMap.keys).sorted()
        }
    }
}
