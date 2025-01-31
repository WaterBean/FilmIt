//
//  SynopsisView.swift
//  FilmIt
//
//  Created by 한수빈 on 1/27/25.
//

import UIKit
import SnapKit

final class SynopsisView: BaseView {
    
    private let headerLabel = {
        let label = UILabel()
        label.text = "Synopsis"
        label.font = .monospacedSystemFont(ofSize: 12, weight: .semibold)
        return label
    }()
    // TODO: - textView foldable하게 구현
    let foldingButton = {
        var config = UIButton.Configuration.plain()
        config.baseForegroundColor = .point
        config.attributedTitle = AttributedString(NSAttributedString(string: "Show", attributes: [.font: UIFont.systemFont(ofSize: 14, weight: .bold)]))
        let button = UIButton()
        button.configuration = config
        return button
    }()
    
    private let textView = {
        let view = UITextView()
        view.text = "이것은 줄거리여이것은 줄거리여이것은 줄거리여이것은 줄거리여이것은 줄거리여이것은 줄거리여이것은 줄거리여이것은 줄거리여이것은 줄거리여이것은 줄거리여이것은 줄거리여이것은 줄거리여이것은 줄거리여이것은 줄거리여이것은 줄거리여이것은 줄거리여"
        view.textColor = .white
        view.backgroundColor = .black
        view.isEditable = false
        view.isScrollEnabled = false
        view.isSelectable = false
        return view
    }()
    
    override func configureHierarchy() {
        [headerLabel, foldingButton, textView].forEach {
            addSubview($0)
        }
    }
    
    override func configureLayout() {
        headerLabel.snp.makeConstraints {
            $0.top.leading.equalTo(safeAreaLayoutGuide).offset(16)
            $0.height.equalTo(20)
        }
        
        foldingButton.snp.makeConstraints {
            $0.top.trailing.equalTo(safeAreaLayoutGuide).inset(12)
        }
        
        // TODO: - 가변 길이 적용
        textView.snp.makeConstraints {
            $0.top.equalTo(headerLabel.snp.bottom).offset(8)
            $0.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            $0.bottom.equalTo(safeAreaLayoutGuide)
            $0.height.equalTo(60)
        }
    }
    
    func updateView(string: String?) {
        textView.text = string
    }
    
    
}
