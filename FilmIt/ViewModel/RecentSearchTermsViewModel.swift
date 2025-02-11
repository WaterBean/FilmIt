//
//  RecentSearchTermsViewModel.swift
//  FilmIt
//
//  Created by 한수빈 on 2/11/25.
//

import Foundation

final class RecentSearchTermsViewModel: BaseViewModel {
    
    struct Input {
        let update: Observable<Void> = Observable(())
        let deleteTerm: Observable<String> = Observable("")
        let searchWithTerm: Observable<String> = Observable("")
        let search: Observable<Void> = Observable(())
        let removeAllTerms: Observable<Void> = Observable(())
    }
    
    struct Output {
        let isNoRecent: Observable<Bool> = Observable(false)
        let terms: Observable<[Dictionary<String, Date>.Element]> = Observable([])
        let searchWithTerm: Observable<String> = Observable("")
        let search: Observable<Void> = Observable(())
    }
    
    private(set) var input = Input()
    private(set) var output = Output()
    
    init() {
        transform()
    }
    
    func transform() {
        input.update.bind { [weak self] in
            guard let self else { return }
            update()
        }
        
        input.deleteTerm.lazyBind { [weak self] term in
            guard let self else { return }
            self.deleteTerm(term)
        }
        
        input.removeAllTerms.lazyBind { [weak self] term in
            guard let self else { return }
            self.removeAllTerm()
        }
        
        input.searchWithTerm.lazyBind { [weak self] string in
            guard let self else { return }
            self.searchByTerm(string)
        }
        
        input.search.lazyBind { [weak self] _ in
            guard let self else { return }
            self.search()
        }
    }
    
    private func update() {
        let recent = self.loadAndSortTerms()
        self.output.terms.value = recent
        self.output.isNoRecent.value = recent.isEmpty
    }
    
    private func loadAndSortTerms() -> [Dictionary<String, Date>.Element] {
        let terms = UserStatusManager.searchTerms.sorted { $0.value > $1.value }
        return terms
    }
    
    private func search() {
        output.search.value = ()
    }
    
    private func deleteTerm(_ term: String) {
        UserStatusManager.removeSearchTerm(keyword: term)
        update()
    }
    
    private func removeAllTerm() {
        UserStatusManager.removeAllSearchTerms()
        update()
    }
    
    private func searchByTerm(_ string: String) {
        output.searchWithTerm.value = string
        update()
    }
    
    
}
