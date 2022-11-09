//
//  RecommendationGroupTableViewController.swift
//  VK
//
//  Created by Алена Панченко on 05.11.2022.
//

import UIKit

typealias GoBackHandler = (Group) -> ()

/// Рекомендуемые группы
final class RecommendationGroupTableViewController: UITableViewController {
    // MARK: - Private Constants

    private enum Constants {
        static let groupIdentifier = "Group"
        static let groupNibName = "GroupTableViewCell"
    }

    // MARK: - Public Properties

    var backHandler: GoBackHandler?
    var recommendationGroupsDataCourse: [Group] = []

    // MARK: - Private Properties

    private var selectedGroup: Group?

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }

    // MARK: - Public Methods

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        recommendationGroupsDataCourse.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        createCell(indexPath: indexPath)
    }

    // MARK: - Table view delegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        goToRootVC(indexPath: indexPath)
    }

    // MARK: - Private Methods

    private func goToRootVC(indexPath: IndexPath) {
        let group = recommendationGroupsDataCourse[indexPath.row]
        recommendationGroupsDataCourse.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        tableView.reloadData()
        selectedGroup = group
        backHandler?(group)
        navigationController?.popToRootViewController(animated: true)
    }

    private func configureTableView() {
        tableView.register(
            UINib(nibName: Constants.groupNibName, bundle: nil),
            forCellReuseIdentifier: Constants.groupIdentifier
        )
    }

    private func createCell(indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.groupIdentifier,
            for: indexPath
        ) as? GroupTableViewCell else { return UITableViewCell() }
        let model = recommendationGroupsDataCourse[indexPath.row]
        cell.update(group: model)
        return cell
    }
}
