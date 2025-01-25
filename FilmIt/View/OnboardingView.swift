//
//  OnboardingView.swift
//  FilmIt
//
//  Created by 한수빈 on 1/25/25.
//

import UIKit
import SnapKit

final class OnboardingView: BaseView {
    
    private let introImageView = {
        let view = UIImageView()
        view.image = .onboarding
        view.contentMode = .scaleAspectFit
        return view
    }()

    private let titleLabel = {
        let label = UILabel()
        label.text = "Onboarding"
        label.font = .italicSystemFont(ofSize: 36)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private let introLabel = {
        let label = UILabel()
        label.text = "당신만의 영화 세상,\n FilmIt을 시작해보세요."
        label.font = .systemFont(ofSize: 16, weight: .light)
        label.textColor = .white
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    let startButton = {
        var config = UIButton.Configuration.borderedProminent()
        config.cornerStyle = .capsule
        config.title = "시작하기"
        config.background.backgroundColor = .black
        config.background.strokeColor = .point
        config.baseForegroundColor = .point
        config.attributedTitle = AttributedString(NSAttributedString(string: "시작하기", attributes: [.font: UIFont.systemFont(ofSize: 16, weight: .semibold)]))
        let button = UIButton()
        button.configuration = config
        return button
    }()
    
    override func configureHierarchy() {
        [introImageView, titleLabel, introLabel, startButton].forEach {
            addSubview($0)
        }
    }
    
    override func configureLayout() {
        introImageView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(20)
            $0.horizontalEdges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(introImageView.snp.bottom).offset(12)
            $0.horizontalEdges.equalTo(introImageView)
        }
        
        introLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(12)
            $0.horizontalEdges.equalTo(introImageView)
        }
        
        startButton.snp.makeConstraints {
            $0.top.equalTo(introLabel.snp.bottom).offset(24)
            $0.height.equalTo(44)
            $0.horizontalEdges.equalTo(introImageView).inset(12)
        }
    }
    
    
}
