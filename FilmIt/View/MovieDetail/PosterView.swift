//
//  PosterView.swift
//  FilmIt
//
//  Created by 한수빈 on 1/28/25.
//

import UIKit
import SnapKit

final class PosterView: BaseView {
    
    private let headerLabel = {
        let label = UILabel()
        label.text = "Poster"
        label.font = .monospacedSystemFont(ofSize: 12, weight: .semibold)
        return label
    }()
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: {
        let layout = UICollectionViewFlowLayout()
        let inset = 16.0
        layout.sectionInset = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        layout.minimumLineSpacing = 16
        layout.scrollDirection = .horizontal
        return layout
    }())
    
    override func configureHierarchy() {
        [headerLabel, collectionView].forEach {
            addSubview($0)
        }
    }
    
    override func configureLayout() {
        headerLabel.snp.makeConstraints {
            $0.top.leading.equalTo(safeAreaLayoutGuide).offset(16)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(headerLabel.snp.bottom)
            $0.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
            $0.height.equalTo(200)
        }
    }
    
    override func configureView() {
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .black
    }

    
}
