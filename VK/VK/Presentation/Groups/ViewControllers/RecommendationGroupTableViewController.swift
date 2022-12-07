// RecommendationGroupTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

typealias GoBackHandler = (Group) -> ()

/// Рекомендуемые группы
final class RecommendationGroupTableViewController: UITableViewController {
    // MARK: - Private Constants

    private enum Constants {
        static let groupIdentifier = "Group"
        static let groupNibName = "GroupTableViewCell"
        static let unknownFailureName = "Неизвестная ошибка"
        static let decodingFailureName = "Ошибка декодирования"
        static let urlFailureName = "Ошибка URL"
    }

    // MARK: - Private Outlets

    @IBOutlet private var searchBar: UISearchBar!

    // MARK: - Public Properties

    var backHandler: GoBackHandler?
    var recommendationGroups: [Group] = []

    // MARK: - Private Properties

    private let networkService = NetworkService()

    private var selectedGroup: Group?
    private var searchingResults: [Group] = []
    private var dataProvider = DataProvider()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }

    // MARK: - Public Methods

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchingResults.count
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
        let group = searchingResults[indexPath.row]
        searchingResults.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        tableView.reloadData()
        selectedGroup = group
        backHandler?(group)
        navigationController?.popToRootViewController(animated: true)
    }

    private func configureTableView() {
        tableView.tableHeaderView = searchBar
        searchingResults = recommendationGroups
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
        let group = searchingResults[indexPath.row]
        cell.configure(group: group, networkService: networkService)
        return cell
    }

    private func getSearchGroups(searchingGroups: String) {
        dataProvider.fetchSearchGroups(searchingGroups: searchingGroups) { [weak self] result in
            guard let self else { return }
            switch result {
            case let .success(groups):
                self.searchingResults = groups
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

/// UISearchBarDelegate
extension RecommendationGroupTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchingResults = []
        if searchText.isEmpty {
            searchingResults = recommendationGroups
        } else {
            getSearchGroups(searchingGroups: searchText.lowercased())
        }
        tableView.reloadData()
    }
}
