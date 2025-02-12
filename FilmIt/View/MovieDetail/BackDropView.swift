//
//  BackDropView.swift
//  FilmIt
//
//  Created by 한수빈 on 1/27/25.
//

import UIKit
import SnapKit

final class BackDropView: BaseView {
    
    let pageControl = {
        let control = UIPageControl()
        control.currentPage = 0
        control.hidesForSinglePage = true
        control.pageIndicatorTintColor = .gray2
        control.backgroundColor = .darkGray
        control.layer.cornerRadius = 12
        control.clipsToBounds = true
        return control
    }()
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = .zero
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        return layout
    }())
    
    private let stackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.alignment = .center
        view.spacing = 4
        return view
    }()
    
    private let dateImageView = {
        let view = UIImageView()
        view.image = UIImage(
            systemName: "calendar",
            withConfiguration: SFConfig.preferringMonochrome()
                .applying(SFConfig(pointSize: 12, weight: .medium))
        )
        return view
    }()
    
    private let voteAverageImageView = {
        let view = UIImageView()
        view.image = UIImage(
            systemName: "star.fill",
            withConfiguration: SFConfig.preferringMonochrome()
                .applying(SFConfig(pointSize: 12, weight: .medium))
        )
        return view
    }()
    
    private let genreIdsImageView = {
        let view = UIImageView()
        view.image = UIImage(
            systemName: "film.fill",
            withConfiguration: SFConfig.preferringMonochrome()
                .applying(SFConfig(pointSize: 12, weight: .medium))
        )
        return view
    }()
    
    let dateLabel = {
        let label = UILabel()
        label.text = "2025-01-01"
        return label
    }()
    
    let voteAverageLabel = {
        let label = UILabel()
        label.text = "0.0"
        return label
    }()
    
    let genreIdsLabel = {
        let label = UILabel()
        label.text = " 없음 "
        return label
    }()
    
    override func configureHierarchy() {
        [collectionView, pageControl, stackView].forEach {
            addSubview($0)
        }
        [dateImageView, dateLabel, voteAverageImageView, voteAverageLabel, genreIdsImageView, genreIdsLabel].forEach {
            stackView.addArrangedSubview($0)
        }
    }
    
    override func configureLayout() {
        collectionView.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(safeAreaLayoutGuide)
            $0.height.equalTo(collectionView.snp.width).multipliedBy(2.0/3.0)
        }
        
        pageControl.snp.makeConstraints {
            $0.centerX.equalTo(safeAreaLayoutGuide)
            $0.bottom.equalTo(collectionView.snp.bottom).inset(10)
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(collectionView.snp.bottom).offset(16)
            $0.centerX.equalTo(safeAreaLayoutGuide)
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(8)
        }
    }
    
    override func configureView() {
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = .black
        [dateLabel, voteAverageLabel, genreIdsLabel].forEach {
            $0.numberOfLines = 1
            $0.textColor = .gray2
            $0.font = UIFont.systemFont(ofSize: 12, weight: .light)
            $0.textAlignment = .center
        }
        [dateImageView, voteAverageImageView, genreIdsImageView].forEach {
            $0.tintColor = .gray2
        }
    }
    
    
}
