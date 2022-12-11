// ParseDataOperation.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Операция по парсингу данных
final class ParseDataOperation<T: Decodable>: Operation {
    // MARK: - Public Properties

    var items: [T] = []

    // MARK: - Public Methods

    override func main() {
        guard let getDataOperation = dependencies.first as? GetDataOperation,
              let data = getDataOperation.data
        else { return }
        do {
            let response = try JSONDecoder().decode(Response<ItemsResponse<T>>.self, from: data)
            items = response.response.items
            print(items)
        } catch {
            print(error.localizedDescription)
        }
    }
}
