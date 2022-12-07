// NewsConfigurable.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Тип протокола и ячейки таблицы
typealias NewsCell = UITableViewCell & NewsConfigurable

/// Протокол добавления данных в ячейки
protocol NewsConfigurable {
    func update(news: NewsPost, networkService: NetworkService?)
}
