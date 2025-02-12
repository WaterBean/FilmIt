//
//  SearchViewController.swift
//  FilmIt
//
//  Created by 한수빈 on 1/26/25.
//

import UIKit
import SnapKit

final class SearchViewController: UIViewController {
    
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
    
    let viewModel = SearchViewModel()
    
    private func bind() {
        viewModel.output.movieList.lazyBind { _ in
            self.tableView.reloadData()
        }
        
        viewModel.output.initialTerm.lazyBind { text in
            print(text, #function)
            self.searchBar.text = text
        }
        
        viewModel.output.isMovieListEmpty.lazyBind { isMovieListEmpty in
            if isMovieListEmpty {
                self.noResultLabel.text = "원하는 검색결과를 찾지 못했습니다."
            } else {
                self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
                self.noResultLabel.text = " "
            }
        }
        
        viewModel.output.becomeResponder.bind { becomeResponder in
            if becomeResponder {
                self.searchBar.becomeFirstResponder()
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    private func searchMoviesBySearchButton(text: String?) {
        viewModel.input.searchMovies.value = text
    }
    
    func searchWithInitialTerm(term: String) {
        viewModel.input.searchWithInitialTerm.value = term
    }
    
    
}


extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.output.movieList.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = viewModel.output.movieList.value[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as? SearchTableViewCell else { return SearchTableViewCell() }
        // FIXME: - 하이라이팅 수정 필요
        cell.configureCell(keyword: "", id: row.id, image: row.posterPath, title: row.title, date: row.releaseDate ?? "", tag: row.genreIds ?? [])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = viewModel.output.movieList.value[indexPath.row]
        let vc = MovieDetailViewController(viewModel: MovieDetailViewModel(movie: row))
        let rightBarButtonItem = UIBarButtonItem(customView: LikeButton(id: row.id))
        pushNavigationWithBarButtonItem(vc: vc, rightBarButtonItem: rightBarButtonItem)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        viewModel.input.searchMoreMovies.value = scrollView.contentOffset.y
    }
    
    
}


extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchMoviesBySearchButton(text: searchBar.text)
    }
    
    
}


extension SearchViewController {
    
    private func configureView() {
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
    
    
}
