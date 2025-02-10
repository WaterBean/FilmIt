//
//  BaseTableViewCell.swift
//  FilmIt
//
//  Created by 한수빈 on 1/26/25.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
    
    static var identifier: String {
        String(describing: self)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: "BaseTableViewCell")
        backgroundColor = .black
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// view.addSubview()를 통해 계층 구조를 정의하는 함수
    func configureHierarchy() { }
    
    /// 제약조건을 통해 뷰를 배치하는 함수
    func configureLayout() { }
    
    /// view의 속성을 변경하는 함수
    func configureView() { }
    

}
