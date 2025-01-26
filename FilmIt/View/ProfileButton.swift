//
//  ProfileButton.swift
//  FilmIt
//
//  Created by 한수빈 on 1/26/25.
//

import UIKit

final class ProfileButton: BaseButton {
 
    convenience init(image: UIImage) {
        self.init(frame: .zero)
        setImage(image, for: .normal)
        contentMode = .scaleAspectFill
        clipsToBounds = true
        layer.borderColor = UIColor.point.cgColor
        DispatchQueue.main.async {
            self.layer.cornerRadius = self.frame.width / 2
        }
    }
    
    func configurePointBorder() {
        layer.borderWidth = 3
        alpha = 1
    }
    
    func configureDisableBorder() {
        layer.borderWidth = 1
        alpha = 0.5
    }
}
