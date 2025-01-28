//
//  ProfileImageSettingViewController.swift
//  FilmIt
//
//  Created by 한수빈 on 1/28/25.
//

import UIKit

final class ProfileImageSettingViewController: UIViewController {

    let mainView = ProfileImageSettingView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "프로필 이미지 설정"
    }
    
    
}
