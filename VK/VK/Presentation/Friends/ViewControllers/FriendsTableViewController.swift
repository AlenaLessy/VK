//
//  FriendsTableViewController.swift
//  VK
//
//  Created by Алена Панченко on 05.11.2022.
//

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
    }

    private enum SectionType {
        case friendsSearch
        case friendsInfo
        case friendsRequest
        case birthday
        case friends(String)
    }

    private lazy var service = NetworkService()

    // MARK: - Private Properties

    private var friendSections: [Character: [Friend]] = [:]
    private var sectionTitles: [Character] = []
    private var generalSectionsCount = 4

    private var sections: [SectionType] = [.friendsSearch, .friendsInfo, .friendsRequest, .birthday]

    private var birthdaysDataSource: [Birthday] = [
        Birthday(name: "Михалыч", imageName: "mi5"),
        Birthday(name: "Потапка", imageName: "mi6"),
        Birthday(name: "Евгений Медведев", imageName: "mi7"),
        Birthday(name: "Топтышка Мишулин", imageName: "mi8")
    ]

    private var friendsDataSource: [Friend] = [
        Friend(name: "Михаил Потапыч", imageNames: ["m1", "m2", "m3"], city: "Сочи"),
        Friend(name: "Медведь Бурый", imageNames: ["m2", "m3", "mi1"], age: 14, city: "Питер"),
        Friend(name: "Мишка Белый", imageNames: ["mi1", "mi6", "mi4"], age: 19, city: "Севастополь"),
        Friend(name: "Коала Пропала", imageNames: ["m3", "mi3", "mi1"]),
        Friend(name: "Гризли Загрызли", imageNames: ["m4", "mi6", "mi4"], age: 42),
        Friend(name: "Миша Цирковой", imageNames: ["m5", "mi6", "mi4"], age: 5, city: "Ростов"),
        Friend(name: "Леха Именинник", imageNames: ["m7", "mi6", "mi4"], age: 31, city: "Краснодар"),
        Friend(name: "Лена Сказочная", imageNames: ["mi5", "mi6", "mi4"], age: 18, city: "Тридевятое царство"),
        Friend(name: "Потап Браун", imageNames: ["mi8", "mi6", "mi4"], age: 16, city: "Сказочный лес")
    ]

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        createSections()
        print("friends")
        service.getFriends()
        print("photos")
        service.getAllPhotos()
        print("groups")
        service.getGroups()
        print("search")
        service.searchGroups()
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
            let model = birthdaysDataSource[indexPath.row]
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: Constants.birthdayIdentifier,
                for: indexPath
            ) as? BirthdayTableViewCell else { return UITableViewCell() }
            cell.update(birthdays: model)
            return cell
        case .friends:
            guard let friend = friendSections[sectionTitles[indexPath.section - generalSectionsCount]]?[indexPath.row],
                  let cell = tableView.dequeueReusableCell(
                      withIdentifier: Constants.friendsIdentifier,
                      for: indexPath
                  ) as? FriendsTableViewCell else { return UITableViewCell() }
            cell.update(friend: friend)
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
            return birthdaysDataSource.count
        case .friends:
            return friendSections[sectionTitles[section - generalSectionsCount]]?.count ?? 0
        }
    }

    private func setupTableViewSelect(indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: Constants.storyBoardName, bundle: nil)
        guard let profileViewController = storyBoard
            .instantiateViewController(withIdentifier: Constants.profileVCIdentifier) as? ProfileViewController
        else { return }
        profileViewController.imageNames = friendsDataSource[indexPath.row].imageNames
        present(profileViewController, animated: true)
    }

    private func createSections() {
        for friend in friendsDataSource {
            guard let firstLetter = friend.name.first else { return }
            if friendSections[firstLetter] != nil {
                friendSections[firstLetter]?.append(friend)
            } else {
                friendSections[firstLetter] = [friend]
                sections.append(.friends(String(firstLetter)))
            }
            sectionTitles = Array(friendSections.keys)
        }
    }
}
