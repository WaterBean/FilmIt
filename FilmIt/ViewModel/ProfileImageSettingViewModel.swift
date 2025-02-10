//
//  ProfileImageSettingViewModel.swift
//  FilmIt
//
//  Created by 한수빈 on 2/9/25.
//

import Foundation

final class ProfileImageSettingViewModel: BaseViewModel {
    
    struct Input {
        let profileSelected: Observable<String?> = Observable(nil)
    }
    
    struct Output {
        let profileSelected: Observable<String?> = Observable(nil)
    }
    
    weak var delegate: ProfileImageDelegate?

    private(set) var input = Input()
    private(set) var output = Output()
    
    init() {
        transform()
    }

    func transform() {
        input.profileSelected.lazyBind { [weak self] profileImageName in
            self?.setImage(profileImageName)
        }
    }
    
    private func setImage(_ string: String?) {
        guard let string else {
            self.output.profileSelected.value = "profile_0"
            return
        }
        self.output.profileSelected.value = string
        self.delegate?.setImage(string: string)

    }
    
    
}
