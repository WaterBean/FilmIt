//
//  BorderButton.swift
//  FilmIt
//
//  Created by 한수빈 on 1/25/25.
//

import UIKit

final class CapsuleBorderButton: UIButton {
    
    convenience init(title: String) {
        var config = UIButton.Configuration.borderedProminent()
        config.cornerStyle = .capsule
        config.background.backgroundColor = .black
        config.background.strokeColor = .point
        config.baseForegroundColor = .point
        config.attributedTitle = AttributedString(NSAttributedString(string: title, attributes: [.font: UIFont.systemFont(ofSize: 16, weight: .semibold)]))
        self.init(frame: .zero)
        self.configuration = config
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
