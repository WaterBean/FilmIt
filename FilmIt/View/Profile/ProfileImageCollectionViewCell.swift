//
//  ProfileImageCollectionCell.swift
//  FilmIt
//
//  Created by 한수빈 on 1/28/25.
//

import UIKit
import SnapKit

final class ProfileImageCollectionViewCell: BaseCollectionViewCell {
    
    private let profileButton = ProfileButton(isPoint: false)
    
    override func configureHierarchy() {
        [profileButton].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func configureLayout() {
        profileButton.snp.makeConstraints {
            $0.edges.equalTo(contentView.safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        
    }


}


