//
//  SearchViewController.swift
//  FilmIt
//
//  Created by 한수빈 on 1/26/25.
//

import UIKit
import SnapKit

final class SearchViewController: UIViewController {
    
    private var movieList = [Movie]() {
        didSet {
        }
    }
    private var page = 1
    private var totalPages = 1
    private var lastUserInput = ""
    private var becomeResponder = true
    
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
        view.rowHeight = 130
        view.backgroundColor = .black
        view.separatorStyle = .singleLine
        view.showsVerticalScrollIndicator = true
        view.scrollsToTop = true
        view.separatorColor = .gray2
        return view
    }()
    
    private let noResultLabel = {
        let label = UILabel()
        label.text = " "
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textColor = .gray2
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
            $0.bottom.leading.equalTo(view.safeAreaLayoutGuide)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
        
        noResultLabel.snp.makeConstraints {
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.centerY.equalTo(view.safeAreaLayoutGuide).offset(-100)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if becomeResponder {
            searchBar.becomeFirstResponder()
        }
    }
    
    private func searchMoviesBySearchButton(text: String) {
        movieList = []
        page = 1
        MovieNetworkClient.request(SearchResponse.self, router: .search(query: text, page: 1)) {
            self.movieList = $0.results
            self.page = $0.page
            self.totalPages = $0.totalPages
            self.tableView.reloadData()
            if self.movieList.count > 0 {
                self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
                self.noResultLabel.text = " "
            } else {
                self.noResultLabel.text = "원하는 검색결과를 찾지 못했습니다."
            }
        } failure: { error in
            print(error)
        }
        UserStatusManager.addSearchTerm(keyword: text)
        becomeResponder = false
        view.endEditing(true)
    }
    
    private func searchMoreMovies() {
        page += 1
        MovieNetworkClient.request(SearchResponse.self, router: .search(query: lastUserInput, page: page)) {
            self.movieList.append(contentsOf: $0.results)
            self.tableView.reloadData()
        } failure: { error in
            print(error)
        }
    }
    
    func searchWithInitialTerm(term: String) {
        searchBar.text = term
        lastUserInput = term
        searchMoviesBySearchButton(text: term)
    }
    
    
}


extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = movieList[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as? SearchTableViewCell else { return SearchTableViewCell() }
        cell.configureCell(id: row.id, image: row.posterPath, title: row.title, date: row.releaseDate, tag: row.genreIds)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = movieList[indexPath.row]
        let vc = MovieDetailViewController()
        vc.movie = row
        let rightBarButtonItem = UIBarButtonItem(customView: LikeButton(id: row.id))
        pushNavigationWithBarButtonItem(vc: vc, rightBarButtonItem: rightBarButtonItem)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y >= (CGFloat(movieList.count) * 90.0) * (3.0 / 5.0) {
            if 1...totalPages ~= page{
                print(scrollView.contentOffset.y, (CGFloat(movieList.count) * 90.0) * (3.0 / 5.0))
                searchMoreMovies()
            }
        }
    }
    
    
}


extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines),
              lastUserInput != text else { return }
        lastUserInput = text
        searchMoviesBySearchButton(text: text)
    }
    
    
}
