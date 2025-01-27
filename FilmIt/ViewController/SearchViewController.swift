//
//  SearchViewController.swift
//  FilmIt
//
//  Created by 한수빈 on 1/26/25.
//

import UIKit
import SnapKit

final class SearchViewController: UIViewController {
    
    var movieList = [String]()
    
    private let searchBar = {
        let bar = UISearchBar()
        bar.keyboardAppearance = .dark
        bar.placeholder = "영화를 검색해보세요."
        bar.searchBarStyle = .minimal
        bar.barStyle = .black
        return bar
    }()
    
    private let tableView = {
        let view = UITableView()
        view.rowHeight = 120
        view.backgroundColor = .black
        view.separatorStyle = .singleLine
        view.separatorColor = .gray2
        return view
    }()
    
    private let noResultLabel = {
        let label = UILabel()
        label.text = "원하는 검색결과를 찾지 못했습니다."
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textColor = .gray2
        label.isHidden = true
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        navigationItem.title = "영화 검색"
        
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
        [searchBar, tableView, noResultLabel].forEach {
            view.addSubview($0)
        }
        
        searchBar.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom)
            $0.bottom.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
        
        noResultLabel.snp.makeConstraints {
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.centerY.equalTo(view.safeAreaLayoutGuide).offset(-100)
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchBar.becomeFirstResponder()
    }
    
    private func searchMovies() {
        // TODO: - fetch search result
        guard let text = searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }
        UserStatusManager.addSearchTerms(keyword: text)
        if movieList.count <= 0 {
            noResultLabel.isHidden = false
        } else {
            noResultLabel.isHidden = true
        }
        view.endEditing(true)
    }
    
    
}


extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as? SearchTableViewCell else { return SearchTableViewCell() }
        cell.configureView()
        return cell
    }
    
    
}


extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchMovies()
    }
    
    
}
