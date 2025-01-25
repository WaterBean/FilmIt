//
//  OnboardingViewController.swift
//  FlimIt
//
//  Created by 한수빈 on 1/24/25.
//

import UIKit

final class OnboardingViewController: UIViewController {

    private let mainView = OnboardingView()
    
    override func loadView() {
        view = mainView
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }

    private func configureView() {
        mainView.startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
    }

    @objc func startButtonTapped() {
        let vc = ProfileSettingViewController()
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        navigationItem.backBarButtonItem = backBarButtonItem
        vc.navigationItem.title = "프로필 설정"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
