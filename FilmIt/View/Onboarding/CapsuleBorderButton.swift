//
//  BorderButton.swift
//  FilmIt
//
//  Created by 한수빈 on 1/25/25.
//

import UIKit

final class CapsuleBorderButton: BaseButton {
    
    convenience init(title: String) {
        self.init(frame: .zero)
        var config = UIButton.Configuration.borderedProminent()
        config.cornerStyle = .capsule
        config.background.backgroundColor = .black
        config.background.strokeColor = .point
        config.baseForegroundColor = .point
        config.attributedTitle = AttributedString(NSAttributedString(string: title, attributes: [.font: UIFont.systemFont(ofSize: 16, weight: .semibold), .foregroundColor: UIColor.point]))
        self.configuration = config
    }
    
    
}
