//
//  DataCell.swift
//  Coronavirus Pandemic
//
//  Created by Nomadic on 9/6/20.
//  Copyright © 2020 Nomadic. All rights reserved.
//

import UIKit
import SnapKit

class DataCell: UICollectionViewCell {
    
    let container: UIView = {
       let view = UIView()
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        view.layer.borderWidth = 0.2
        view.layer.borderColor = #colorLiteral(red: 0, green: 0.3285208941, blue: 0.5748849511, alpha: 0.5)
        return view
    }()
    
    let title: UILabel = {
       let label = UILabel()
        label.font = UIFont(name: "Futura-Medium", size: 12)
        label.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        return label
    }()
    
    let dataTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Futura-Medium", size: 20)
        label.textColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        addSubview(container)
        container.addSubview(title)
        container.addSubview(dataTitle)
        
        container.snp.makeConstraints { (set) in
            set.top.equalToSuperview().offset(10)
            set.left.equalToSuperview()
            set.right.equalToSuperview()
            set.bottom.equalToSuperview().offset(-10)
        }
        
        title.snp.makeConstraints { (set) in
            set.top.equalTo(container.snp.top).offset(10)
            set.left.equalTo(container.snp.left).offset(10)
        }
        
        dataTitle.snp.makeConstraints { (set) in
            set.centerY.equalTo(container.snp.centerY)
            set.centerX.equalTo(container.snp.centerX)
        }
    }
}
