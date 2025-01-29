//
//  SettingViewController.swift
//  FilmIt
//
//  Created by 한수빈 on 1/25/25.
//

import UIKit

final class SettingViewController: UIViewController {

    let mainView = SettingView()
    
    let sectionList: [SettingOptions] = SettingOptions.allCases

    enum SettingOptions: String, CaseIterable {
        
        case total = "전체 설정"
        
        var subOption: [String] {
            return switch self {
            case .total: ["자주 묻는 질문", "1:1 문의", "알림 설정", "탈퇴하기"]
            }
        }
        
        func option() -> String {
            self.rawValue
        }
        
        
    }

    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "설정"
        mainView.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.profileContainerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(profileViewTapped)))

    }

    @objc private func profileViewTapped() {
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


extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionList[section].subOption.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        cell.backgroundColor = .black
        cell.isUserInteractionEnabled = ("탈퇴하기" == sectionList[indexPath.section].subOption[indexPath.row])
        var config = cell.defaultContentConfiguration()
        config.text = sectionList[indexPath.section].subOption[indexPath.row]
        config.attributedText = NSAttributedString(string: sectionList[indexPath.section].subOption[indexPath.row], attributes: [.font: UIFont.systemFont(ofSize: 14), .foregroundColor: UIColor.white])
        cell.selectionStyle = .none
        cell.contentConfiguration = config
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if "탈퇴하기" == sectionList[indexPath.section].subOption[indexPath.row] {
            let alert = UIAlertController(title: "탈퇴하기", message: "탈퇴를 하면 데이터가 모두 초기화됩니다. 탈퇴 하시겠습니까?", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "취소", style: .cancel)
            let confirmAction = UIAlertAction(title: "확인", style: .default) { _ in
                UserStatusManager.status = .logout
                UserStatusManager.status.replaceScene()
            }
            alert.addAction(cancelAction)
            alert.addAction(confirmAction)
            present(alert, animated: true)
        }
    }
    
    
}


