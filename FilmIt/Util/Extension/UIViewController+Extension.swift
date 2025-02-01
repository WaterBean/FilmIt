//
//  UIViewController+Extension.swift
//  FilmIt
//
//  Created by 한수빈 on 1/28/25.
//

import UIKit

extension UIViewController {
    
    func pushNavigationWithBarButtonItem(vc: UIViewController, rightBarButtonItem: UIBarButtonItem?) {
        let backBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: self, action: nil)
        navigationItem.backBarButtonItem = backBarButtonItem
        vc.navigationItem.rightBarButtonItem = rightBarButtonItem
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func presentProfileSetting() {
        let vc = ProfileNicknameSettingViewController()
        let nav = UINavigationController(rootViewController: vc)
        let saveButton = UIBarButtonItem(title: "저장", image: nil, target: vc, action: #selector(vc.saveButtonTapped))
        saveButton.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 16, weight: .bold)], for: .normal)
        let dismissButton = UIBarButtonItem(title: " ", image: UIImage(systemName: "xmark"), target: vc, action: #selector(vc.dismissButtonTapped))
        nav.navigationBar.topItem?.rightBarButtonItem = saveButton
        nav.navigationBar.topItem?.leftBarButtonItem = dismissButton
        nav.sheetPresentationController?.prefersGrabberVisible = true
        present(nav, animated: true)
    }
    
    
}
