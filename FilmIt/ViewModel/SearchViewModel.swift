//
//  SearchViewModel.swift
//  FilmIt
//
//  Created by 한수빈 on 2/11/25.
//

import Foundation

final class SearchViewModel: BaseViewModel {
    
    struct Input {
        let searchWithInitialTerm: Observable<String> = Observable("")
        let searchMovies: Observable<String?> = Observable(nil)
        let searchMoreMovies: Observable<Double> = Observable(0)
    }
    
    struct Output {
        let movieList = Observable([Movie]())
        let isMovieListEmpty = Observable(false)
        let initialTerm: Observable<String> = Observable("")
        let becomeResponder = Observable(true)
    }
    
    private(set) var input = Input()
    private(set) var output = Output()
    
    private var page = 1
    private var totalPages = 1
    private var lastUserInput = ""
    private var lastUserSelect = IndexPath()

    
    init() {
        transform()
    }
    
    private func isPagination(offset: Double) -> Bool {
        if offset >= (CGFloat(output.movieList.value.count) * 90.0) * (3.0 / 5.0) {
            if 1...totalPages ~= page{
                print(offset, (CGFloat(output.movieList.value.count) * 90.0) * (3.0 / 5.0))
                return true
            }
        }
        return false
    }
    
    func transform() {
        
        input.searchWithInitialTerm.lazyBind { [weak self] text in
            guard let self else { return }
            DispatchQueue.main.async {
                self.output.initialTerm.value = text
            }
            lastUserInput = text
            searchMoviesByKeyword(text: text)
        }
        
        input.searchMovies.lazyBind { [weak self] text in
            guard let self,
                  let text = text?.trimmingCharacters(in: .whitespacesAndNewlines),
                  lastUserInput != text else { return }
            lastUserInput = text
            searchMoviesByKeyword(text: text)
        }
        
        input.searchMoreMovies.lazyBind { [weak self] offset in
            guard let self else { return }
            isPagination(offset: offset) ? searchMoreMovies() : ()
        }
        
        
    }
    
    private func searchMoviesByKeyword(text: String) {
        MovieNetworkClient.request(SearchResponse.self, router: MovieNetworkRouter.search(query: text, page: 1)) { result in
            self.output.movieList.value = []
            switch result {
            case .success(let success):
                self.output.movieList.value = success.results
                self.output.isMovieListEmpty.value = self.output.movieList.value.isEmpty
                self.page = success.page
                self.totalPages = success.totalPages
            case .failure(let failure):
                print(failure)
            }
        }
        UserStatusManager.addSearchTerm(keyword: text)
        output.becomeResponder.value = false
    }
    
    private func searchMoreMovies() {
        page += 1
        MovieNetworkClient.request(SearchResponse.self, router: MovieNetworkRouter.search(query: lastUserInput, page: page)) { result in
            switch result {
            case .success(let success):
                self.output.movieList.value.append(contentsOf: success.results)
                self.output.isMovieListEmpty.value = self.output.movieList.value.isEmpty
            case .failure(let failure):
                print(failure.localizedDescription)
                
            }
        }
    }
    
    private func searchWithInitialTerm(term: String) {
        lastUserInput = term
        searchMoviesByKeyword(text: term)
    }
}
