//
//  SearchView.swift
//  Coronavirus Pandemic
//
//  Created by Nomadic on 9/6/20.
//  Copyright © 2020 Nomadic. All rights reserved.
//

import UIKit
import SnapKit

class SearchView: UIView {
    
    let searchHolder: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        view.layer.cornerRadius = 7.5
        view.layer.shadowColor = #colorLiteral(red: 0, green: 0.3285208941, blue: 0.5748849511, alpha: 1)
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowRadius = 0.5
        view.layer.shadowOpacity = 0.7
        return view
    }()
    
    let searchBar: UISearchBar = {
        let search = UISearchBar()
        search.backgroundColor = .white
        search.layer.cornerRadius = 10
        search.clipsToBounds = true
        search.placeholder = "search country"
        search.tintColor = #colorLiteral(red: 0, green: 0.3285208941, blue: 0.5748849511, alpha: 1)
        search.barTintColor = #colorLiteral(red: 0, green: 0.3285208941, blue: 0.5748849511, alpha: 1)
        search.searchBarStyle = .minimal
        search.autocapitalizationType = .words
        return search
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        addSubview(searchHolder)
        searchHolder.addSubview(searchBar)
        
        if let textfield = searchBar.value(forKey: "searchField") as? UITextField {
            textfield.textColor = #colorLiteral(red: 0, green: 0.3285208941, blue: 0.5748849511, alpha: 1)
            textfield.font = UIFont(name: "Futura-Medium", size: 17)
        }
        
        
        searchHolder.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview()
        }
        
        searchBar.snp.makeConstraints { (make) in
            make.top.equalTo(searchHolder.snp.top).offset(10)
            make.left.equalTo(searchHolder.snp.left).offset(10)
            make.right.equalTo(searchHolder.snp.right).offset(-10)
            make.bottom.equalTo(searchHolder.snp.bottom).offset(-10)
        }
    }
}
