//
//  ProfileImageSettingViewModel.swift
//  FilmIt
//
//  Created by 한수빈 on 2/9/25.
//

import Foundation

final class ProfileImageSettingViewModel {
    

    weak var delegate: ProfileImageDelegate?

    let inputProfileSelected: Observable<String?> = Observable(nil)
    
    let outputProfileSelected: Observable<String?> = Observable(nil)
    
    init() {
        inputProfileSelected.lazyBind { [weak self] profileImageName in
            self?.setImage(profileImageName)
        }
    }
    
    private func setImage(_ string: String?) {
        guard let string else {
            self.outputProfileSelected.value = "profile_0"
            return
        }
        self.outputProfileSelected.value = string
        self.delegate?.setImage(string: string)

    }
    
    
}
