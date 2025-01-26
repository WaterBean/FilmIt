//
//  TodayMoviesCollectionViewCell.swift
//  FilmIt
//
//  Created by 한수빈 on 1/26/25.
//

import UIKit
import SnapKit

final class TodayMoviesCollectionViewCell: BaseCollectionViewCell {
    
    private let posterImageView = {
        let view = UIImageView()
        view.contentMode = .scaleToFill
        view.clipsToBounds = true
        view.layer.cornerRadius = 12
        return view
    }()
    
    private let titleLabel = {
        let label = UILabel()
        label.font = .largeTitle
        return label
    }()
    
    private let descriptionLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.numberOfLines = 2
        label.textColor = .gray1
        return label
    }()
    
    private let heartButton = HeartButton(isFilled: false)
    
    override func configureHierarchy() {
        [posterImageView, titleLabel, descriptionLabel, heartButton].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func configureLayout() {
        posterImageView.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(safeAreaLayoutGuide)
            $0.bottom.equalTo(titleLabel.snp.top)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(posterImageView.snp.bottom)
            $0.leading.equalTo(safeAreaLayoutGuide)
            $0.trailing.lessThanOrEqualTo(heartButton.snp.leading)
            $0.bottom.equalTo(descriptionLabel.snp.top)
            $0.height.equalTo(22)
        }
        
        heartButton.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.top)
            $0.trailing.equalTo(safeAreaLayoutGuide)
            $0.bottom.equalTo(descriptionLabel.snp.top)
            $0.size.equalTo(44)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.bottom.equalTo(safeAreaLayoutGuide)
            $0.horizontalEdges.equalTo(safeAreaLayoutGuide)
            $0.height.equalTo(40)
        }
    }
    
    override func configureView() {
        posterImageView.image = .profile10
        titleLabel.text = "기생충"
        descriptionLabel.text = "이것은 영화설명이여이것은 영화설명이여이것은 영화설명이여이것은 영화설명이여이것은 영화설명이여이것은 영화설명이여"
    }
    
    
}
