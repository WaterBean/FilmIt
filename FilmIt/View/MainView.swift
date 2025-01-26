//
//  MainView.swift
//  FilmIt
//
//  Created by 한수빈 on 1/25/25.
//

import UIKit
import SnapKit

final class MainView: BaseView {
    
    let profileContainerView = ProfileContainerView()
    
    override func configureHierarchy() {
        [profileContainerView].forEach {
            addSubview($0)
        }
    }
    
    override func configureLayout() {
        profileContainerView.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
        }
    }
    
    override func configureView() {
        
    }
    
    
}
