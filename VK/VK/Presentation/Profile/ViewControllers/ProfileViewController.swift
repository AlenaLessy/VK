//
//  ProfileViewController.swift
//  VK
//
//  Created by Алена Панченко on 10.11.2022.
//

import UIKit

/// Профиль
final class ProfileViewController: UIViewController {
    // MARK: - Private Outlets

    @IBOutlet private var profileImageView: UIImageView!

    // MARK: - Public Properties

    var imageNames: [String] = []

    // MARK: - Private Properties

    private var index = 0

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupImages()
        addRightTapGestures()
        addLeftTapGestures()
    }

    // MARK: - Private Methods

    @objc private func tapGestureAction(gesture: UISwipeGestureRecognizer) {
        switch gesture.direction {
        case .left:
            swipe(xShift: -500, currentIndex: 1)
        case .right:
            swipe(xShift: 500, currentIndex: -1)
        default:
            break
        }
    }

    private func setupImages() {
        guard let imageName = imageNames.first else { return }
        profileImageView.image = UIImage(named: imageName)
    }

    private func addRightTapGestures() {
        let gestureRight = UISwipeGestureRecognizer(target: self, action: #selector(tapGestureAction))
        gestureRight.direction = .right
        profileImageView.addGestureRecognizer(gestureRight)
    }
    
    private func addLeftTapGestures() {
        let gestureLeft = UISwipeGestureRecognizer(target: self, action: #selector(tapGestureAction))
        gestureLeft.direction = .left
        profileImageView.addGestureRecognizer(gestureLeft)
    }
    

    private func swipe(xShift: Int, currentIndex: Int) {
        index += currentIndex
        guard index < imageNames.count,
              index >= 0
        else {
            index -= currentIndex
            return
        }
        UIView.animate(withDuration: 0.5) {
            let shift = CGAffineTransform(translationX: CGFloat(xShift), y: 0)
            self.profileImageView.transform = shift.concatenating(CGAffineTransform(scaleX: 0.6, y: 0.6))
            self.profileImageView.layer.opacity = 0.2
        }
    completion: { _ in
            self.profileImageView.transform = CGAffineTransform(translationX: CGFloat(-xShift), y: 0)
            UIView.animate(withDuration: 0.5, animations: {
                self.profileImageView.layer.opacity = 1
                self.profileImageView.transform = .identity
                self.profileImageView.image = UIImage(named: self.imageNames[self.index])
            })
        }
    }
}
