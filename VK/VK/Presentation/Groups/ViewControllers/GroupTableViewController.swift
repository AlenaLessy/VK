//
//  GroupTableViewController.swift
//  VK
//
//  Created by Алена Панченко on 05.11.2022.
//

import UIKit

/// Группы пользователя
final class GroupTableViewController: UITableViewController {
    // MARK: - Private Constants

    private enum Constants {
        static let groupIdentifier = "Group"
        static let groupNibName = "GroupTableViewCell"
        static let recommendationGroupSegueName = "RecommendationGroup"
    }

    // MARK: - Private Outlets

    @IBOutlet private var addGroupBarButtonItem: UIBarButtonItem!

    // MARK: - Private Properties

    private var groupsDataCourse: [Group] = [
        Group(groupName: "Прокат велосипедов", groupImageName: "1")
    ]

    private var recommendationGroupsDataCourse: [Group] = [
        Group(groupName: "Медведи на велосипеде", groupImageName: "2"),
        Group(groupName: "Цирковые мишки", groupImageName: "3"),
        Group(groupName: "Уют в берлоге", groupImageName: "4"),
        Group(groupName: "Воспитание детей", groupImageName: "5"),
        Group(groupName: "Сообщество белых медведей", groupImageName: "6"),
        Group(groupName: "Плаваем вместе", groupImageName: "7")
    ]

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }

    // MARK: - Public Methods

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == Constants.recommendationGroupSegueName else { return }
        let casted = segue.destination as? RecommendationGroupTableViewController
        casted?.recommendationGroupsDataCourse = recommendationGroupsDataCourse
        casted?.backHandler = { [weak self] group in
            guard let self else { return }
            self.groupsDataCourse.insert(group, at: 0)
            self.tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
            guard let index = self.recommendationGroupsDataCourse.firstIndex(where: { $0 == group }) else { return }
            self.recommendationGroupsDataCourse.remove(at: index)
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        groupsDataCourse.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        createCell(indexPath: indexPath)
    }

    override func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) {
        let model = groupsDataCourse[indexPath.row]
        if editingStyle == .delete {
            groupsDataCourse.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            recommendationGroupsDataCourse.append(model)
        }
    }

    // MARK: - Private Methods

    private func configureTableView() {
        tableView.register(
            UINib(nibName: Constants.groupNibName, bundle: nil),
            forCellReuseIdentifier: Constants.groupIdentifier
        )
    }

    private func createCell(indexPath: IndexPath) -> UITableViewCell {
        let model = groupsDataCourse[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.groupIdentifier,
            for: indexPath
        ) as? GroupTableViewCell else { return UITableViewCell() }
        cell.update(group: model)
        return cell
    }
}
