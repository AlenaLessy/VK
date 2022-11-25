// ImageView + Extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Расширение для добавления картинки из интернета
extension UIImageView {
    func loadImage(imageURL: String) {
        if let url = URL(string: imageURL) {
            URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
                guard let self else { return }
                DispatchQueue.main.async {
                    guard let data,
                          let image = UIImage(data: data) else { return }
                    self.image = image
                }
            }.resume()
        }
    }
}
