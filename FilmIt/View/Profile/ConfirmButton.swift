//
//  ConfirmButton.swift
//  FilmIt
//
//  Created by 한수빈 on 2/9/25.
//

import UIKit

final class ConfirmButton: BaseButton {
    
    init(title: String) {
        super.init(frame: .zero)
        var config = UIButton.Configuration.filled()
        config.cornerStyle = .capsule
        config.attributedTitle = AttributedString(NSAttributedString(string: title, attributes: [.font: UIFont.largeTitle, .foregroundColor: UIColor.white]))
        
        self.configuration = config
        self.configurationUpdateHandler = { button in
            switch button.state {
            case .normal:
                button.configuration?.background.backgroundColor = .activeButton
            case .disabled:
                button.configuration?.background.backgroundColor = .gray2
            default: break
            }
            
        }
    }
    
}
