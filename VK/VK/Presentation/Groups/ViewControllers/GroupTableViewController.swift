// GroupTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Группы пользователя
final class GroupTableViewController: UITableViewController {
    // MARK: - Private Constants

    private enum Constants {
        static let groupIdentifier = "Group"
        static let groupNibName = "GroupTableViewCell"
        static let recommendationGroupSegueName = "RecommendationGroup"
        static let unknownFailureName = "Неизвестная ошибка"
        static let decodingFailureName = "Ошибка декодирования"
        static let urlFailureName = "Ошибка URL"
    }

    // MARK: - Private Properties

    private var groupsDataCourse: [Group] = []
    private var networkService = NetworkService()
    private var groups: [Group] = []
    private var recommendationGroups: [Group] = []

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        loadGroups()
    }

    // MARK: - Public Methods

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == Constants.recommendationGroupSegueName else { return }
        let casted = segue.destination as? RecommendationGroupTableViewController
        casted?.recommendationGroups = recommendationGroups
        casted?.backHandler = { [weak self] group in
            guard let self else { return }
            self.groups.insert(group, at: 0)
            self.tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
            guard let index = self.groups.firstIndex(where: { $0 == group }) else { return }
            self.recommendationGroups.remove(at: index)
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        groups.count
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
        let model = groups[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.groupIdentifier,
            for: indexPath
        ) as? GroupTableViewCell else { return UITableViewCell() }
        cell.update(group: model)
        return cell
    }

    private func loadGroups() {
        networkService.fetchGroups { [weak self] result in
            guard let self else { return }
            switch result {
            case let .success(data):
                self.groups = data.response.groups
                self.tableView.reloadData()
            case .failure(.unknown):
                print(Constants.urlFailureName)
            case .failure(.decodingFailure):
                print(Constants.decodingFailureName)
            case .failure(.urlFailure):
                print(Constants.urlFailureName)
            }
        }
    }
}
