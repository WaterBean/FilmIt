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
        control.numberOfPages = 5
        control.currentPage = 1
        control.pageIndicatorTintColor = .gray2
        control.currentPageIndicatorTintColor = .white
        return control
    }()
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = .zero
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        return layout
    }())
    
    private let infoLabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .gray1
        label.text = "2024-12-24 어쩌구 저저구 뭐시기 맞습니다 네네"
        label.textAlignment = .center
        return label
    }()
    
    
    override func configureHierarchy() {
        [collectionView, pageControl, infoLabel].forEach {
            addSubview($0)
        }
    }
    
    override func configureLayout() {
        collectionView.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(safeAreaLayoutGuide)
            $0.height.equalTo(collectionView.snp.width).multipliedBy(2.0/3.0)
        }
        
        pageControl.snp.makeConstraints {
            $0.centerX.equalTo(safeAreaLayoutGuide)
            $0.bottom.equalTo(collectionView.snp.bottom)
            $0.height.equalTo(40)
        }
        
        infoLabel.snp.makeConstraints {
            $0.top.equalTo(collectionView.snp.bottom).offset(8)
            $0.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(16)
        }
    }
    
    
    override func configureView() {
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = .black
    }
    
    func updateView(releaseDate: String?, voteAverage: Double? ,genreIds: [Int]?) {
        let date = releaseDate != nil ? releaseDate! : "2024-01-01"
        let average = voteAverage != nil ? "\(voteAverage!)" : "0.0"
        let ids = genreIds != nil ? genreIds! : []
        infoLabel.text = "\(date) \(average) \(ids)"
    }
    
    
}
