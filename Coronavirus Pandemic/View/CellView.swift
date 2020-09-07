//
//  CellView.swift
//  Coronavirus Pandemic
//
//  Created by Nomadic on 9/6/20.
//  Copyright © 2020 Nomadic. All rights reserved.
//

import Foundation
import SnapKit

class CellView: UITableViewCell {
    
    static let identifier = "cell"
    
    let cellContainer: UIView = {
       let view = UIView()
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        view.layer.cornerRadius = 7.5
        view.layer.shadowColor = #colorLiteral(red: 0, green: 0.3285208941, blue: 0.5748849511, alpha: 1)
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowRadius = 0.5
        view.layer.shadowOpacity = 0.7
        return view
    }()
    
    let countryLabel: UILabel = {
       let label = UILabel()
        label.textColor = #colorLiteral(red: 0, green: 0.3285208941, blue: 0.5748849511, alpha: 1)
        label.text = "Northern Mariana Islands"
        label.font = UIFont(name: "Futura-Medium", size: 17)
        label.numberOfLines = 0
        return label
    }()
    
    let arrayImage: UIImageView = {
       let image = UIImageView()
        let sizeConfiguration = UIImage.SymbolConfiguration(scale: .medium)
        image.image = UIImage(systemName: "chevron.right", withConfiguration: sizeConfiguration)
        image.tintColor = #colorLiteral(red: 0, green: 0.3285208941, blue: 0.5748849511, alpha: 1)
        return image
    }()
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        addSubview(cellContainer)
        cellContainer.addSubview(countryLabel)
        cellContainer.addSubview(arrayImage)
        
        customizeView()
    }
    
    func customizeView() {
        cellContainer.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-10)
            make.height.equalTo(50)
        }
        
        countryLabel.snp.makeConstraints { (make) in
            make.left.equalTo(cellContainer.snp.left).offset(20)
            make.centerY.equalTo(cellContainer.snp.centerY)
        }
        
        arrayImage.snp.makeConstraints { (make) in
            make.centerY.equalTo(cellContainer.snp.centerY)
            make.right.equalTo(cellContainer.snp.right).offset(-10)
        }
    }
}
