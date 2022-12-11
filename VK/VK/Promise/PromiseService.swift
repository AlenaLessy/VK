// PromiseService.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import PromiseKit

/// Сетевые запросы на Promise
final class PromiseService {
    // MARK: - Private Constants

    private enum Constants {
        static let baseUrl = "https://api.vk.com/"
        static let getFriendsMethod = "/method/friends.get"
        static let parameterTokenName = "access_token"
        static let parameterfieldsName = "fields"
        static let parameterVName = "v"
        static let parameterLandName = "land"
        static let parameterOwnerId = "owner_id"
        static let parameterLandValue = "ru"
        static let parameterVersionValue = "5.131"
        static let parameterfieldsValue = "photo_100"
        static let parameterOrderValue = "order"
        static let parameterOrderName = "name"
    }

    // MARK: - Private Properties

    private let friendsParameters: Parameters = [
        Constants.parameterTokenName: "\(Session.shared.token)",
        Constants.parameterfieldsName: Constants.parameterfieldsValue,
        Constants.parameterVName: Constants.parameterVersionValue,
        Constants.parameterLandName: Constants.parameterLandValue,
        Constants.parameterOrderName: Constants.parameterOrderValue
    ]

    // MARK: - Public Methods

    func fetchFriends() -> Promise<Response<ItemsResponse<Friend>>> {
        let promise = Promise<Response<ItemsResponse<Friend>>> { resolve in
            let baseURL = Constants.baseUrl
            let path = "\(Constants.getFriendsMethod)"
            let url = URL(string: "\(baseURL)\(path)")
            AF.request(url ?? "", parameters: friendsParameters).responseData { response in
                guard let data = response.data else { return }
                do {
                    let items = try JSONDecoder().decode(Response<ItemsResponse<Friend>>.self, from: data)
                    resolve.fulfill(items)
                } catch {
                    resolve.reject(error)
                }
            }
        }
        return promise
    }
}
