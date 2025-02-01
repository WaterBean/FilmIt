//
//  SettingView.swift
//  FilmIt
//
//  Created by 한수빈 on 1/29/25.
//

import UIKit
import SnapKit

final class SettingView: BaseView {
    
    let profileContainerView = ProfileContainerView()
    
    let tableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .black
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = .gray2
        return tableView
    }()
    
    override func configureHierarchy() {
        [profileContainerView, tableView].forEach {
            addSubview($0)
        }
    }
    
    override func configureLayout() {
        profileContainerView.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(profileContainerView.snp.bottom).offset(16)
            $0.leading.bottom.equalTo(safeAreaLayoutGuide)
            $0.trailing.equalTo(safeAreaLayoutGuide).inset(16)
        }
    }
    
}
