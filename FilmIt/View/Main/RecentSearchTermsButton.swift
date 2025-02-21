//
//  RecentSearchTermsButton.swift
//  FilmIt
//
//  Created by 한수빈 on 1/26/25.
//

import UIKit

final class RecentSearchTermsButton: BaseButton {
    
    weak var delegate: RecentSearchTermsButtonDelegate?
    let term: String
    
    init(frame: CGRect, term: String) {
        self.term = term
        super.init(frame: frame)
    }
    
    convenience init(term: String) {
        self.init(frame: .zero, term: term)
        var config = UIButton.Configuration.filled()
        config.attributedTitle = AttributedString(NSAttributedString(string: term, attributes: [.font: UIFont.systemFont(ofSize: 14, weight: .medium), .foregroundColor: UIColor.black]))
        config.cornerStyle = .capsule
        config.imagePlacement = .trailing
        config.background.backgroundColor = .white
        config.image = UIImage(
            systemName: "xmark",
            withConfiguration: SFConfig.preferringMonochrome()
                .applying(SFConfig(pointSize: 10, weight: .medium))
        )
        config.imagePadding = 6
        config.baseForegroundColor = .black
        self.configuration = config
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc func buttonTapped(sender: UIButton, event: UIEvent?) {
        if let touch = event?.allTouches?.first{
            let location = touch.location(in: self)
            let deleteArea = bounds.width - 30
            print(location.x, deleteArea)
            if location.x > deleteArea {
                delegate?.deleteTerm(term)
            } else {
                delegate?.searchTerm(term)
            }
        }
    }
    
    
}

protocol RecentSearchTermsButtonDelegate: AnyObject {
    
    func searchTerm(_ term: String)
    func deleteTerm(_ term: String)
    
}
