//
//  ProfileSettingViewController.swift
//  FilmIt
//
//  Created by 한수빈 on 1/25/25.
//

import UIKit

final class ProfileSettingViewController: UIViewController {

    let mainView = ProfileSettingView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
}
