// LoadDataService.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import UIKit

/// Формирование запроса
class LoadDataService {
    // MARK: - Private Constants

    private enum Constants {
        static let getFriendsDescription = "/method/friends.get"
        static let getAllPhotosDescription = "/method/photos.getAll"
        static let getGroupsDescription = "/method/groups.get"
        static let searchGroupsDescription = "/method/groups.search"
        static let getNewsFeedDescription = "/method/newsfeed.get"
        static let baseUrl = "https://api.vk.com/"
        static let emptyString = ""
    }

    // MARK: - Types

    enum NetworkServiceMethodKind: CustomStringConvertible {
        case getFriends
        case getAllPhotos
        case getGroups
        case searchGroups
        case getNewsFeed

        var description: String {
            switch self {
            case .getFriends:
                return Constants.getFriendsDescription
            case .getAllPhotos:
                return Constants.getAllPhotosDescription
            case .getGroups:
                return Constants.getGroupsDescription
            case .searchGroups:
                return Constants.searchGroupsDescription
            case .getNewsFeed:
                return Constants.getNewsFeedDescription
            }
        }
    }

    // MARK: - Public Methods

    func loadData<T: Decodable>(
        componentsPath: NetworkServiceMethodKind,
        parameters: Parameters,
        handler: @escaping (Result<T, NetworkError>) -> ()
    ) {
        let baseURL = Constants.baseUrl
        let path = "\(componentsPath.description)"
        guard let url = URL(string: baseURL + path) else {
            handler(.failure(.urlFailure))
            return
        }
        AF.request(url, parameters: parameters).responseData { response in
            guard let data = response.data else { return }
            do {
                let response = try JSONDecoder().decode(Response<T>.self, from: data)

                handler(.success(response.response))
            } catch {
                handler(.failure(.decodingFailure))
            }
        }
    }

    func loadGroups(componentsPath: NetworkServiceMethodKind, parameters: Parameters) {
        let operationQueue = OperationQueue()
        let request = groupRequest(componentsPath: componentsPath, parameters: parameters)
        let getDataOperation = GetDataOperation(request: request)
        operationQueue.addOperation(getDataOperation)
        let parseGroupDataOperation = ParseDataOperation<Group>()
        parseGroupDataOperation.addDependency(getDataOperation)
        operationQueue.addOperation(parseGroupDataOperation)
        let saveToRealmGroupOperation = SaveToRealmOperation<Group>()
        saveToRealmGroupOperation.addDependency(parseGroupDataOperation)
        operationQueue.addOperation(saveToRealmGroupOperation)
    }

    // MARK: - Private Methods

    private func groupRequest(componentsPath: NetworkServiceMethodKind, parameters: Parameters) -> DataRequest {
        let baseURL = Constants.baseUrl
        let path = "\(componentsPath.description)"
        let url = URL(string: baseURL + path)
        let request = AF.request(url ?? Constants.emptyString, parameters: parameters)
        return request
    }
}
