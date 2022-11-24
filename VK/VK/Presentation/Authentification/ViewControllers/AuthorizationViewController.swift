// AuthorizationViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit
import WebKit

/// Экран авторизации
final class AuthorizationViewController: UIViewController {
    // MARK: - Private Constants

    private enum Constants {
        static let urlComponentsSchemeName = "https"
        static let urlComponentsHostName = "oauth.vk.com"
        static let urlComponentsPathName = "/authorize"
        static let queryItemsIdName = "client_id"
        static let queryItemsURLRedirectName = "redirect_uri"
        static let queryItemsDisplayName = "display"
        static let queryItemsScopeName = "scope"
        static let queryItemsResponseTypeName = "response_type"
        static let queryItemsVersionName = "v"
        static let queryItemsRevokeName = "revoke"
        static let queryItemsURLRedirectValue = "https://oauth.vk.com/blank.html"
        static let queryItemsDisplayValue = "mobile"
        static let queryItemsScopeValue = "262150"
        static let queryItemsResponseTypeValue = "token"
        static let queryItemsVersionValue = "5.131"
        static let queryItemsRevokeValue = "0"
        static let urlPath = "/blank.html"
        static let separationOfComponents = "&"
        static let equalSign = "="
        static let accessTokenName = "access_token"
        static let storyBoardName = "Main"
        static let tabBarControllerIdentifier = "TabBar"
        static let userId = "user_id"
    }

    // MARK: - Private Outlets

    @IBOutlet private var wKWebView: WKWebView! {
        didSet {
            wKWebView.navigationDelegate = self
        }
    }

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        wKWebViewConfigureRequest()
    }

    // MARK: - Private Methods

    private func wKWebViewConfigureRequest() {
        var urlComponents = URLComponents()
        urlComponents.scheme = Constants.urlComponentsSchemeName
        urlComponents.host = Constants.urlComponentsHostName
        urlComponents.path = Constants.urlComponentsPathName
        urlComponents.queryItems = [
            URLQueryItem(name: Constants.queryItemsIdName, value: "\(Session.shared.clientId)"),
            URLQueryItem(
                name: Constants.queryItemsURLRedirectName,
                value:
                Constants.queryItemsURLRedirectValue
            ),
            URLQueryItem(name: Constants.queryItemsDisplayName, value: Constants.queryItemsDisplayValue),
            URLQueryItem(name: Constants.queryItemsScopeName, value: Constants.queryItemsScopeValue),
            URLQueryItem(name: Constants.queryItemsResponseTypeName, value: Constants.queryItemsResponseTypeValue),
            URLQueryItem(name: Constants.queryItemsVersionName, value: Constants.queryItemsVersionValue),
            URLQueryItem(name: Constants.queryItemsRevokeName, value: Constants.queryItemsRevokeValue)
        ]
        guard let url = urlComponents.url else { return }
        let request = URLRequest(url: url)
        wKWebView.load(request)
    }

    private func showTabBarController() {
        let mainStoryboard = UIStoryboard(name: Constants.storyBoardName, bundle: nil)
        let tabBarController = mainStoryboard
            .instantiateViewController(withIdentifier: Constants.tabBarControllerIdentifier)
        view.window?.rootViewController = tabBarController
        view.window?.makeKeyAndVisible()
    }
}

// MARK: - WKNavigationDelegate

extension AuthorizationViewController: WKNavigationDelegate {
    func webView(
        _ webView: WKWebView,
        decidePolicyFor navigationResponse:
        WKNavigationResponse,
        decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void
    ) {
        guard let url = navigationResponse.response.url, url.path == Constants.urlPath,
              let fragment = url.fragment
        else {
            decisionHandler(.allow)
            return
        }
        let params = fragment
            .components(separatedBy: Constants.separationOfComponents)
            .map { $0.components(separatedBy: Constants.equalSign) }.reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
            }
        guard let token = params[Constants.accessTokenName],
              let userId = params[Constants.userId]
        else { return }
        Session.shared.token = token
        Session.shared.userId = userId
        decisionHandler(.cancel)
        showTabBarController()
    }
}
