//
//  MBTISelectView.swift
//  FilmIt
//
//  Created by 한수빈 on 2/9/25.
//

import UIKit
import SnapKit

final class MBTISelectView: BaseView {
    
    private let mbtiLabel = {
        let label = UILabel()
        label.text = "MBTI"
        label.font = .largeTitle
        label.textColor = .black
       return label
    }()
    
    let e = MBTIButton(title: "E")
    let s = MBTIButton(title: "S")
    let t = MBTIButton(title: "T")
    let j = MBTIButton(title: "J")
    let i = MBTIButton(title: "I")
    let n = MBTIButton(title: "N")
    let f = MBTIButton(title: "F")
    let p = MBTIButton(title: "P")
    
    lazy var mbtiButtons = [e, s, t, j, i, n, f, p]
    
    override func configureHierarchy() {
        [mbtiLabel, e, s, t, j, i, n, f, p].forEach {
            addSubview($0)
        }
    }
    
    override func configureLayout() {
        mbtiLabel.snp.makeConstraints {
            $0.top.leading.equalTo(safeAreaLayoutGuide)
        }
        
        e.snp.makeConstraints {
            $0.top.equalTo(mbtiLabel.snp.top)
            $0.leading.greaterThanOrEqualTo(mbtiLabel.snp.trailing).offset(48)
            $0.trailing.equalTo(s.snp.leading).offset(-12)
            $0.size.equalTo(50)
        }
        
        s.snp.makeConstraints {
            $0.top.equalTo(e.snp.top)
            $0.trailing.equalTo(t.snp.leading).offset(-12)
            $0.size.equalTo(50)
        }
        
        t.snp.makeConstraints {
            $0.top.equalTo(s.snp.top)
            $0.trailing.equalTo(j.snp.leading).offset(-12)
            $0.size.equalTo(50)
        }
        j.snp.makeConstraints {
            $0.top.equalTo(t.snp.top)
            $0.trailing.equalTo(safeAreaLayoutGuide).offset(-12)
            $0.size.equalTo(50)
        }
        i.snp.makeConstraints {
            $0.top.equalTo(e.snp.bottom).offset(12)
            $0.leading.equalTo(e.snp.leading)
            $0.size.equalTo(50)
        }
        n.snp.makeConstraints {
            $0.top.equalTo(i.snp.top)
            $0.trailing.equalTo(f.snp.leading).offset(-12)
            $0.size.equalTo(50)
        }
        f.snp.makeConstraints {
            $0.top.equalTo(n.snp.top)
            $0.trailing.equalTo(p.snp.leading).offset(-12)
            $0.size.equalTo(50)
        }
        p.snp.makeConstraints {
            $0.top.equalTo(f.snp.top)
            $0.trailing.equalTo(safeAreaLayoutGuide).offset(-12)
            $0.size.equalTo(50)
        }
    }
    
    override func configureView() {
        backgroundColor = .white
    }
    
    
}
