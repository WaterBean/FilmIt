//
//  RecentSearchTermsView.swift
//  FilmIt
//
//  Created by 한수빈 on 1/26/25.
//

import UIKit
import SnapKit

final class RecentSearchTermsView: BaseView {
    
    private let scrollView = {
        let view = UIScrollView()
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        return view
    }()
    
    private let stackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 16
        return view
    }()
    
    private let recentsLabel = {
        let label = UILabel()
        label.text = "최근검색어"
        label.font = .largeTitle
        label.textColor = .white
        return label
    }()

    private let noRecentsLabel = {
        let label = UILabel()
        label.text = "최근 검색어 내역이 없습니다."
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textColor = .gray1
        label.isHidden = true
        return label
    }()
    
    private let deleteRecentsButton = {
        var config = UIButton.Configuration.plain()
        config.baseForegroundColor = .point
        config.attributedTitle = AttributedString(NSAttributedString(string: "전체 삭제", attributes: [.font: UIFont.systemFont(ofSize: 14, weight: .bold)]))
        let button = UIButton()
        button.configuration = config
        return button
    }()
    
    override func configureHierarchy() {
        [recentsLabel, deleteRecentsButton, scrollView].forEach {
            addSubview($0)
        }
        
        [stackView, noRecentsLabel].forEach {
            addSubview($0)
        }
        
        if UserStatusManager.searchTerms.count == 0 {
            noRecentsLabel.isHidden = false
        } else {
            for (_, item) in UserStatusManager.searchTerms.enumerated() {
                let button = RecentSearchTermsButton(title: item)
                stackView.addArrangedSubview(button)
            }
        }
    }
    
    override func configureLayout() {
        recentsLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(16)
            $0.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
        }
        
        deleteRecentsButton.snp.makeConstraints {
            $0.centerY.equalTo(recentsLabel.snp.centerY)
            $0.trailing.equalTo(safeAreaLayoutGuide).inset(8)
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(recentsLabel.snp.bottom).offset(8)
            $0.horizontalEdges.equalTo(safeAreaLayoutGuide)
            $0.height.equalTo(50)
        }
        
        stackView.snp.makeConstraints {
            $0.horizontalEdges.equalTo(scrollView).inset(16)
            $0.centerY.equalTo(scrollView.snp.centerY)
        }
        
        noRecentsLabel.snp.makeConstraints {
            $0.center.equalTo(scrollView.snp.center)
        }
    }
    
    override func configureView() {
        scrollView.backgroundColor = .black
        stackView.backgroundColor = .black
    }
    
    @objc func func1() {
        print(#function)
    }
       
    @objc func func2() {
        print(#function)
    }
    
    
}
