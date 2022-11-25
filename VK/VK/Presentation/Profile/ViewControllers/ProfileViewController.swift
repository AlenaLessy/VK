// ProfileViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Профиль
final class ProfileViewController: UIViewController {
    // MARK: Private Constants

    private enum Constants {
        static let leftSwipeXShift = -500
        static let rightSwipeXShift = 500
        static let leftSwipeCurrentIndex = 1
        static let rightSwipeCurrentIndex = -1
        static let swipeAnimationDuration = 0.5
        static let animateTranslationY: CGFloat = 0
        static let animateTransformScaleX = 0.6
        static let animateTransformScaleY = 0.6
        static let animateDisappearingProfileImageViewLayerOpacity: Float = 0.2
        static let animateEmergingProfileImageViewLayerOpacity: Float = 1
        static let unknownFailureName = "Неизвестная ошибка"
        static let decodingFailureName = "Ошибка декодирования"
        static let urlFailureName = "Ошибка URL"
    }

    // MARK: - Private Outlets

    @IBOutlet private var profileImageView: UIImageView!

    // MARK: - Public Properties

    var photoNames: [Photo] = []
    var userId = 0

    // MARK: - Private Properties

    private var index = 0
    private var networkService = NetworkService()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        addRightTapGestures()
        addLeftTapGestures()
        fetchAllPhotos()
    }

    // MARK: - Private Methods

    @objc private func tapGestureAction(gesture: UISwipeGestureRecognizer) {
        switch gesture.direction {
        case .left:
            swipe(xShift: Constants.leftSwipeXShift, currentIndex: Constants.leftSwipeCurrentIndex)
        case .right:
            swipe(xShift: Constants.rightSwipeXShift, currentIndex: Constants.rightSwipeCurrentIndex)
        default:
            break
        }
    }

    private func fetchAllPhotos() {
        networkService.fetchAllPhotos(userId: userId) { [weak self] result in
            guard let self else { return }
            switch result {
            case let .success(data):
                self.photoNames = data.response.photos
                self.setupImages()
            case .failure(.unknown):
                print(Constants.urlFailureName)
            case .failure(.decodingFailure):
                print(Constants.decodingFailureName)
            case .failure(.urlFailure):
                print(Constants.urlFailureName)
            }
        }
    }

    private func setupImages() {
        guard let imageName = photoNames.first?.photoPaths.last?.url
        else { return }
        profileImageView.loadImage(imageURL: imageName)
    }

    private func addRightTapGestures() {
        let swipeGestureRight = UISwipeGestureRecognizer(target: self, action: #selector(tapGestureAction))
        swipeGestureRight.direction = .right
        profileImageView.addGestureRecognizer(swipeGestureRight)
    }

    private func addLeftTapGestures() {
        let swipeGestureLeft = UISwipeGestureRecognizer(target: self, action: #selector(tapGestureAction))
        swipeGestureLeft.direction = .left
        profileImageView.addGestureRecognizer(swipeGestureLeft)
    }

    private func swipe(xShift: Int, currentIndex: Int) {
        index += currentIndex
        guard index < photoNames.count,
              index >= 0
        else {
            index -= currentIndex
            return
        }
        UIView.animate(withDuration: Constants.swipeAnimationDuration) {
            let shift = CGAffineTransform(translationX: CGFloat(xShift), y: Constants.animateTranslationY)
            self.profileImageView.transform = shift
                .concatenating(CGAffineTransform(
                    scaleX: Constants.animateTransformScaleX,
                    y: Constants.animateTransformScaleY
                ))
            self.profileImageView.layer.opacity = Constants.animateDisappearingProfileImageViewLayerOpacity
        }
    completion: { _ in
            self.profileImageView.transform = CGAffineTransform(
                translationX: CGFloat(-xShift),
                y: Constants.animateTranslationY
            )
            UIView.animate(withDuration: Constants.swipeAnimationDuration, animations: {
                self.profileImageView.layer.opacity = Constants.animateEmergingProfileImageViewLayerOpacity
                self.profileImageView.transform = .identity
            })
        }
    }
}
