//
//  CastCollectionViewCell.swift
//  FilmIt
//
//  Created by 한수빈 on 1/28/25.
//

import UIKit
import SnapKit

final class CastCollectionViewCell: BaseCollectionViewCell {
    
    private let castImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    private let actorNameLabel = {
        let label = UILabel()
        label.text = "현빈"
        return label
    }()
    
    private let characterNameLabel = {
        let label = UILabel()
        label.text = "Ahn Jung-geun"
        return label
    }()
    
    override func configureHierarchy() {
        [castImageView, actorNameLabel, characterNameLabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func configureLayout() {
        castImageView.snp.makeConstraints {
            $0.leading.verticalEdges.equalTo(contentView.safeAreaLayoutGuide)
            $0.size.equalTo(60)
        }
        
        actorNameLabel.snp.makeConstraints {
            $0.leading.equalTo(castImageView.snp.trailing).offset(4)
            $0.trailing.equalTo(contentView.safeAreaLayoutGuide)
            $0.top.equalTo(contentView.safeAreaLayoutGuide).offset(8)
        }
        characterNameLabel.snp.makeConstraints {
            $0.leading.equalTo(castImageView.snp.trailing).offset(4)
            $0.trailing.equalTo(contentView.safeAreaLayoutGuide)
            $0.bottom.equalTo(contentView.safeAreaLayoutGuide).offset(-8)
        }
    }
    
    override func configureView() {
        castImageView.image = .profile0
        castImageView.layer.cornerRadius = 36
    }


}
