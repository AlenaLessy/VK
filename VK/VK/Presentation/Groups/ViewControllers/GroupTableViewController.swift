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

    private let dataProvider = DataProvider()

    private var photoService: PhotoService?
    private var groups: [Group] = []
    private var recommendationGroups: [Group] = []

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        fetchGroups()
        observe()
        photoServiceConfigure()
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
        if editingStyle == .delete {
            groups.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    // MARK: - Private Methods

    private func photoServiceConfigure() {
        photoService = PhotoService(container: self)
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
        ) as? GroupTableViewCell,
            let groupImage = photoService?.photo(atIndexpath: indexPath, byUrl: groups[indexPath.row].photo)
        else { return UITableViewCell() }
        cell.configure(group: groups[indexPath.row], groupImage: groupImage)
        return cell
    }

    private func observe() {
        dataProvider.observeGroups { [weak self] groups in
            guard let self else { return }
            self.groups = groups
            self.tableView.reloadData()
        }
    }

    private func fetchGroups() {
        dataProvider.fetchGroups()
    }
}
