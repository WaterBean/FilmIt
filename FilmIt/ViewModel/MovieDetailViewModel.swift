//
//  MovieDetailViewModel.swift
//  FilmIt
//
//  Created by 한수빈 on 2/12/25.
//

import Foundation

final class MovieDetailViewModel: BaseViewModel {
    
    struct Input {
        let initialLoad: Observable<Void> = Observable(())
    }
    
    struct Output {
        let movieTitle: Observable<String> = Observable("")
        let backdrop: Observable<[FilePath]> = Observable([])
        let pageControlStatus: Observable<(Int, Bool)> = Observable((0, true))
        let releaseDate: Observable<String> = Observable("")
        let voteAverage: Observable<String> = Observable("")
        let genreText: Observable<String> = Observable("")
        let overview: Observable<String> = Observable("")
        let cast: Observable<[Cast]> = Observable([])
        let poster: Observable<[FilePath]> = Observable([])
    }
    
    private let movie: Movie
    private var image: ImageResponse?
    private var credit: CreditResponse?
    
    private(set) var input: Input
    private(set) var output: Output
    
    init(movie: Movie) {
        self.movie = movie
        input = Input()
        output = Output()
        
        transform()
    }
    
    func transform() {
        input.initialLoad.bind { [weak self] _ in
            self?.fetchMovieDetail()
        }
    }
    
    private func fetchMovieDetail() {
        let group = DispatchGroup()
        group.enter()
        fetchImages(group)
        group.enter()
        fetchCredit(group)
        
        processFetchResults(group)
        
    }
    
    private func fetchImages(_ group: DispatchGroup) {
        MovieNetworkClient.request(ImageResponse.self, router: MovieNetworkRouter.image(id: movie.id)) { result in
            switch result {
            case .success(let success):
                self.image = success
            case .failure(let failure):
                print(failure)
            }
            group.leave()
        }
    }
    
    private func fetchCredit(_ group: DispatchGroup) {
        MovieNetworkClient.request(CreditResponse.self, router: MovieNetworkRouter.credit(id: movie.id)) { result in
            switch result {
            case .success(let success):
                self.credit = success
            case .failure(let failure):
                print(failure)
            }
            group.leave()
        }
    }
    
    private func processFetchResults(_ group: DispatchGroup) {
        group.notify(queue: .main) { [weak self] in
            guard let self else { return }
            output.movieTitle.value = movie.title
            updateBackdrop(self)
            output.overview.value = movie.overview
            updateDate()
            updateAverage()
            updateGenre()
            output.cast.value = credit?.cast ?? []
            output.poster.value = image?.posters ?? []
        }
    }
    
    private func updateBackdrop(_ self: MovieDetailViewModel) {
        if let sliceArray = self.image?.backdrops.prefix(5) {
            let backdrops = Array(sliceArray)
            let count = backdrops.count
            output.backdrop.value = backdrops
            output.pageControlStatus.value = backdrops.count < 2 ? (count, true) : (count, false)
        } else {
            output.backdrop.value = []
            output.pageControlStatus.value = (0, true)
        }
    }
    
    private func updateDate() {
        let date = movie.releaseDate ?? "날짜 정보 없음"
        let dateText = "\(date)   |    "
        output.releaseDate.value = dateText
    }
    
    private func updateAverage() {
        let average = movie.voteAverage != nil ? "\(String(format: "%.2f", movie.voteAverage!))" : "평점 정보 없음"
        let averageText = "\(average)   |    "
        output.voteAverage.value = averageText
    }
    
    private func updateGenre() {
        let ids = MovieGenre.getGenreNames(movie.genreIds ?? [])
        let idsText = ids.isEmpty ? "장르 정보 없음" : ids.joined(separator: ", ")
        output.genreText.value = idsText
    }
    
    
}
