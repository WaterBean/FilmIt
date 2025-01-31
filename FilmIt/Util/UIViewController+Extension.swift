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
    
    
}
