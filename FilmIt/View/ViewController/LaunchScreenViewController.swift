//
//  LaunchScreenViewController.swift
//  FilmIt
//
//  Created by 한수빈 on 2/1/25.
//

import UIKit
import SnapKit

final class LaunchScreenViewController: UIViewController {
    
    private let splashImageView = {
        let view = UIImageView()
        view.image = .splash
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private let titleLabel = {
        let label = UILabel()
        label.text = "FilmIt"
        label.textColor = .white
        label.font = .italicSystemFont(ofSize: 36, weight: .semibold)
        return label
    }()
    
    private let subTitleLabel = {
        let label = UILabel()
        label.text = "한수빈"
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .light)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        configureHierarchy()
        configureLayout()
        transitionView()
    }
    
    private func configureHierarchy() {
        [splashImageView, titleLabel, subTitleLabel].forEach {
            view.addSubview($0)
        }
    }
    
    private func configureLayout() {
        splashImageView.snp.makeConstraints {
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.centerY.equalTo(view.safeAreaLayoutGuide).offset(-100)
            $0.size.equalTo(200)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalTo(splashImageView)
            $0.top.equalTo(splashImageView.snp.bottom).offset(64)
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.centerX.equalTo(titleLabel)
            $0.top.equalTo(titleLabel.snp.bottom).offset(24)
        }
    }
    
    private func transitionView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.7)  {
            UIView.animate(withDuration: 0.3) {
                self.view.alpha = 0
            } completion: { _ in
                self.dismiss(animated: false)
            }
        }
        
    }
    
    
}
