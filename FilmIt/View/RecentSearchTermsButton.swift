//
//  RecentSearchTermsButton.swift
//  FilmIt
//
//  Created by 한수빈 on 1/26/25.
//

import UIKit

final class RecentSearchTermsButton: BaseButton {
    
    convenience init(title: String) {
        self.init(frame: .zero)
        var config = UIButton.Configuration.filled()
        config.attributedTitle = AttributedString(NSAttributedString(string: title, attributes: [.font: UIFont.systemFont(ofSize: 14, weight: .bold), .foregroundColor: UIColor.black]))
        config.cornerStyle = .capsule
        config.imagePlacement = .trailing
        config.background.backgroundColor = .white
        config.image = UIImage(systemName: "xmark")
        config.baseForegroundColor = .black
        self.configuration = config
    }
    
    
}
