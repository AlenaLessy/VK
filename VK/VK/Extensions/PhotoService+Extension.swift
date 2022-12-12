// PhotoService+Extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Расширешие для хранения ссылок на таблицу и коллекцию и обновление ее элементов
extension PhotoService {
    class TableViewController: DataReloadable {
        // MARK: - Private Properties

        private let tableViewController: UITableViewController

        // MARK: - Initializers

        init(tableViewController: UITableViewController) {
            self.tableViewController = tableViewController
        }

        // MARK: - Public Methods

        func reloadRow(atIndexpath indexPath: IndexPath) {
            tableViewController.tableView.reloadRows(at: [indexPath], with: .none)
        }
    }

    class CollectionViewController: DataReloadable {
        // MARK: - Private Properties

        private let collectionViewController: UICollectionViewController

        // MARK: - Initializers

        init(collectionViewController: UICollectionViewController) {
            self.collectionViewController = collectionViewController
        }

        // MARK: - Public Methods

        func reloadRow(atIndexpath indexPath: IndexPath) {
            collectionViewController.collectionView.reloadItems(at: [indexPath])
        }
    }
}
