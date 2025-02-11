//
//  ProfileContainerView.swift
//  FilmIt
//
//  Created by 한수빈 on 1/25/25.
//

import UIKit
import SnapKit

final class ProfileContainerView: BaseView {
    
    let viewModel = ProfileContainerViewModel()
    
    private let profileButton = ProfileButton(isPoint: true)
    
    private let nicknameLabel = {
        let label = UILabel()
        label.font = .largeTitle
        label.textColor = .white
        return label
    }()
    
    private let joinDateLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.textColor = .gray2
        return label
    }()
    
    private let chevronSymbol = {
        let view = UIImageView()
        view.image = UIImage(systemName: "chevron.forward", withConfiguration: UIImage.SymbolConfiguration(paletteColors: [.gray2]))
        view.contentMode = .scaleAspectFill
        return view
    }()

    private let movieBoxArchiveButton = {
        var config = UIButton.Configuration.filled()
        config.background.backgroundColor = .movieBoxButton
        config.cornerStyle = .small
        let button = UIButton()
        button.configuration = config
        return button
    }()
    
    convenience init() {
        self.init(frame: .zero)
        backgroundColor = UIColor(white: 0.15, alpha: 1)
        clipsToBounds = true
        layer.cornerRadius = 12
        isUserInteractionEnabled = true
        bind()
    }
    
    override func configureHierarchy() {
        [profileButton, nicknameLabel, joinDateLabel, chevronSymbol, movieBoxArchiveButton].forEach {
            addSubview($0)
        }
    }
    
    override func configureLayout() {
        profileButton.snp.makeConstraints {
            $0.top.leading.equalTo(safeAreaLayoutGuide).offset(16)
            $0.size.equalTo(50)
        }
        
        nicknameLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(20)
            $0.leading.equalTo(profileButton.snp.trailing).offset(12)
        }
        
        joinDateLabel.snp.makeConstraints {
            $0.top.equalTo(nicknameLabel.snp.bottom).offset(6)
            $0.leading.equalTo(nicknameLabel.snp.leading)
        }
        
        chevronSymbol.snp.makeConstraints {
            $0.centerY.equalTo(profileButton)
            $0.trailing.equalTo(safeAreaLayoutGuide).inset(16)
            $0.size.equalTo(16)
        }
        
        movieBoxArchiveButton.snp.makeConstraints {
            $0.top.equalTo(profileButton.snp.bottom).offset(12)
            $0.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(44)
        }
    }
    
    private func bind() {
        viewModel.output.profile.bind { [weak self] string in
            self?.profileButton.setImage(UIImage(named: string), for: .normal)
        }
        
        viewModel.output.joinDate.bind { [weak self] joinDate in
            self?.joinDateLabel.text = joinDate
        }
        
        viewModel.output.nickname.bind { [weak self]  nickname in
            self?.nicknameLabel.text = nickname
        }
        
        viewModel.output.likeMovieCountText.bind { [weak self] text in
            self?.movieBoxArchiveButton.configuration?.attributedTitle = text
        }
    }
    
}
