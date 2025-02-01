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
        label.font = .monospacedSystemFont(ofSize: 16, weight: .semibold)
        label.textColor = .white
        return label
    }()
    
    let foldingButton = {
        var config = UIButton.Configuration.plain()
        config.baseForegroundColor = .point
        let button = UIButton()
        button.configuration = config
        let handler: UIButton.ConfigurationUpdateHandler = { button in
            switch button.state {
            case .normal:
                button.configuration?.attributedTitle = AttributedString(NSAttributedString(string: "Show", attributes: [.font: UIFont.systemFont(ofSize: 14, weight: .bold)]))
            case .selected:
                button.configuration?.attributedTitle = AttributedString(NSAttributedString(string: "Hide", attributes: [.font: UIFont.systemFont(ofSize: 14, weight: .bold)]))
                button.configuration?.background.backgroundColor = .clear
            default:
                return
            }
        }
        button.configurationUpdateHandler = handler
        return button
    }()
    
    private let textView = {
        let view = UITextView()
        view.text = " "
        view.textColor = .white
        view.backgroundColor = .black
        view.isEditable = false
        view.isScrollEnabled = false
        view.isSelectable = false
        view.textContainerInset = .zero
        view.font = .systemFont(ofSize: 14)
        view.textContainer.lineFragmentPadding = 0
        view.textContainer.lineBreakMode = .byTruncatingTail
        return view
    }()
    
    private var expandedHeight: CGFloat = 60
    
    override func configureHierarchy() {
        [headerLabel, foldingButton, textView].forEach {
            addSubview($0)
        }
    }
    
    override func configureLayout() {
        headerLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(16)
            $0.leading.equalTo(safeAreaLayoutGuide).offset(16)
            $0.height.equalTo(20)
        }
        
        foldingButton.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).inset(8)
            $0.trailing.equalTo(safeAreaLayoutGuide).inset(4)
        }
        
        textView.snp.makeConstraints {
            $0.top.equalTo(headerLabel.snp.bottom).offset(8)
            $0.leading.equalTo(safeAreaLayoutGuide).inset(16)
            $0.trailing.equalTo(safeAreaLayoutGuide).inset(12)
            $0.bottom.equalTo(safeAreaLayoutGuide)
            $0.height.equalTo(60)
        }
    }
    
    func updateView(string: String?) {
        textView.text = string
        let size = CGSize(width: textView.frame.width, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        expandedHeight = estimatedSize.height
        
        textView.snp.updateConstraints {
            if foldingButton.isSelected {
                textView.textContainer.maximumNumberOfLines = 0
                $0.height.equalTo(max(expandedHeight, 60))
            } else {
                textView.textContainer.maximumNumberOfLines = 0
                $0.height.equalTo(60)
            }
        }
        self.layoutIfNeeded()
    }
    
    
}
