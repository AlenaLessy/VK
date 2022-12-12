// DataReloadable.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол для обновления таблицы
protocol DataReloadable {
    func reloadRow(atIndexpath indexPath: IndexPath)
}
