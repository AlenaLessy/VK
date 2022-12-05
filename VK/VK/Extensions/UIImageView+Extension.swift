// UIImageView+Extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Расширение для добавления картинки из интернета
extension UIImageView {
    func loadImage(imageURL: String, networkService: NetworkService) {
        if let url = URL(string: imageURL) {
            networkService.fetchFotoData(url) { [weak self] data in
                guard let self,
                      let image = UIImage(data: data)
                else { return }
                self.image = image
            }
        }
    }
}
