//
//  MainView.swift
//  FilmIt
//
//  Created by 한수빈 on 1/25/25.
//

import UIKit
import SnapKit

final class MainView: BaseView {
    
    private let profileContainerView = ProfileContainerView()
    let recentSearchTermsView = RecentSearchTermsView()

    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        layout.scrollDirection = .horizontal
        return layout
    }())
    
    private let todayMoviesLabel = {
        let label = UILabel()
        label.text = "오늘의 영화"
        label.font = .largeTitle
        label.textColor = .white
        return label
    }()
    
    override func configureHierarchy() {
        [profileContainerView, recentSearchTermsView, todayMoviesLabel, collectionView].forEach {
            addSubview($0)
        }
    }
    
    override func configureLayout() {
        profileContainerView.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
        }
        
        recentSearchTermsView.snp.makeConstraints {
            $0.top.equalTo(profileContainerView.snp.bottom)
            $0.horizontalEdges.equalTo(safeAreaLayoutGuide)
            $0.height.equalTo(100)
        }
        
        todayMoviesLabel.snp.makeConstraints {
            $0.top.equalTo(recentSearchTermsView.snp.bottom)
            $0.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(todayMoviesLabel.snp.bottom)
            $0.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        collectionView.backgroundColor = .black
    }
    
    
}
