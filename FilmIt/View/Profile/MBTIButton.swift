//
//  MBTIButton.swift
//  FilmIt
//
//  Created by 한수빈 on 2/8/25.
//

import UIKit

final class MBTIButton: BaseButton {
    
    init(title: String) {
        super.init(frame: .zero)
        var config = UIButton.Configuration.borderedProminent()
        config.cornerStyle = .capsule
        config.baseForegroundColor = .blue
        
        config.background.strokeWidth = 1
        self.configuration = config
        self.configurationUpdateHandler = { button in
            switch button.state {
            case .normal:
                button.configuration?.baseBackgroundColor = .clear
                button.configuration?.attributedTitle = AttributedString(NSAttributedString(string: title, attributes: [.font: UIFont.systemFont(ofSize: 14, weight: .medium), .foregroundColor: UIColor.gray2]))
                button.configuration?.background.strokeColor = .gray2
            case .selected:
                button.configuration?.baseBackgroundColor = .activeButton
                button.configuration?.attributedTitle = AttributedString(NSAttributedString(string: title, attributes: [.font: UIFont.systemFont(ofSize: 14, weight: .medium), .foregroundColor: UIColor.white]))
                button.configuration?.background.strokeColor = .activeButton
            default: break
            }
        }
    }
    
    
}
