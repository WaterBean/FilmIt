//
//  LikeButton.swift
//  FilmIt
//
//  Created by 한수빈 on 1/26/25.
//

import UIKit

final class LikeButton: BaseButton {
    
    var id: Int {
        didSet {
            isSelected = UserStatusManager.likeMovies.contains(id)
        }
    }
    
    init(frame: CGRect, id: Int) {
        self.id = id
        super.init(frame: frame)
    }
    
    convenience init(id: Int = 0) {
        self.init(frame: .zero, id: id)
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: "heart")
        config.imagePlacement = .trailing
        config.imagePadding = 0
        config.baseForegroundColor = .point
        config.background.backgroundColor = .clear
        configuration = config
        configurationUpdateHandler = { button in
            switch button.state {
            case .normal:
                button.configuration?.image = UIImage(systemName: "heart")
            case .selected:
                button.configuration?.image = UIImage(systemName: "heart.fill")
            default: break
            }
        }
        isSelected = UserStatusManager.likeMovies.contains(id)
        addTarget(self, action: #selector(updateStatus), for: .touchUpInside)
    }
    
    @objc func updateStatus(sender: UIButton) {
        isSelected.toggle()
        if isSelected {
            UserStatusManager.addLike(movieId: id)
        } else {
            UserStatusManager.removeLike(movieId: id)
        }
    }
 
    
    
}
