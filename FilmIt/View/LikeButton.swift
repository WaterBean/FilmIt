//
//  LikeButton.swift
//  FilmIt
//
//  Created by 한수빈 on 1/26/25.
//

import UIKit

final class LikeButton: BaseButton {
    
    convenience init(isFilled: Bool) {
        self.init(frame: .zero)
        setImage(UIImage(systemName: "heart"), for: .normal)
        contentMode = .scaleAspectFill
        tintColor = .point
    }
    
    
}
