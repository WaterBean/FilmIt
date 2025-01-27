//
//  MovieDetailView.swift
//  FilmIt
//
//  Created by 한수빈 on 1/27/25.
//

import UIKit
import SnapKit

final class MovieDetailView: BaseView {
    
    private let scrollView = {
        let view = UIScrollView()
        view.alwaysBounceHorizontal = false
        view.backgroundColor = .black
        return view
    }()

    private let contentView = UIView()

    let backDropView = BackDropView()
    let synopsisView = SynopsisView()
    
    override func configureHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        [backDropView, synopsisView].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func configureLayout() {
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(safeAreaLayoutGuide)

        }
        
        contentView.snp.makeConstraints {
            $0.width.equalTo(scrollView.snp.width)
            $0.verticalEdges.equalTo(scrollView)
        }
        
        backDropView.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(contentView)
        }
        
        synopsisView.snp.makeConstraints {
            $0.top.equalTo(backDropView.snp.bottom)
            $0.bottom.horizontalEdges.equalTo(contentView)
        }
    }
    
    override func configureView() {
        
    }
}


