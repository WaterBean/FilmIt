//
//  ProfileButton.swift
//  FilmIt
//
//  Created by 한수빈 on 1/26/25.
//

import UIKit

final class ProfileButton: BaseButton {
 
    convenience init(image: UIImage? = nil, isPoint: Bool) {
        self.init(frame: .zero)
        setImage(image, for: .normal)
        contentMode = .scaleAspectFill
        clipsToBounds = true
        layer.borderColor = UIColor.activeButton.cgColor
        layer.borderWidth = isPoint ? 3 : 1
        alpha = isPoint ? 1 : 0.5
    }
    
    func configurePointBorder() {
        layer.borderWidth = 3
        layer.borderColor = UIColor.activeButton.cgColor
        alpha = 1
    }
    
    func configureDisableBorder() {
        layer.borderWidth = 1
        layer.borderColor = UIColor.gray2.cgColor
        alpha = 0.5
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.width / 2
    }
    
}
