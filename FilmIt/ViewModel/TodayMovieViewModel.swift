//
//  TodayMovieViewModel.swift
//  FilmIt
//
//  Created by 한수빈 on 2/11/25.
//

import Foundation

final class TodayMovieViewModel: BaseViewModel {
    
    struct Input {
        let initialFetch: Observable<Void> = Observable(())
    }
    
    struct Output {
        let trendingMovieList: Observable<[Movie]> = Observable([])
    }
    
    private(set) var input = Input()
    private(set) var output = Output()
    
    init() {
        transform()
    }
    
    func transform() {
        input.initialFetch.bind { [weak self] in
            self?.fetchTrendingMovie()
        }
    }
    
    private func fetchTrendingMovie() {
        MovieNetworkClient.request(TrendingResponse.self, router: MovieNetworkRouter.trending) { result in
            switch result {
            case .success(let success):
                self.output.trendingMovieList.value = success.results
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    
}
