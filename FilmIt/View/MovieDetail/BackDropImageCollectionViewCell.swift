//
//  BackDropImageCollectionViewCell.swift
//  FilmIt
//
//  Created by 한수빈 on 1/27/25.
//

import UIKit
import SnapKit

final class BackDropImageCollectionViewCell: BaseCollectionViewCell {
    
    let backDropImageView = UIImageView()
    
    override func configureHierarchy() {
        contentView.addSubview(backDropImageView)
    }
    
    override func configureLayout() {
        backDropImageView.snp.makeConstraints {
            $0.edges.equalTo(contentView)
        }

    }
    
    override func configureView() {
        backDropImageView.image = .profile0
    }
    
    
}
