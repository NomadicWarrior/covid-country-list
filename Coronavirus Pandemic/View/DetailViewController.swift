//
//  DetailViewController.swift
//  Coronavirus Pandemic
//
//  Created by Nomadic on 9/6/20.
//  Copyright © 2020 Nomadic. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    // UI
    let backButton: UIImageView = {
        let image = UIImageView()
        let sizeConfiguration = UIImage.SymbolConfiguration(pointSize: 25, weight: .bold)
        image.image = UIImage(systemName: "chevron.left", withConfiguration: sizeConfiguration)
        image.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        image.isUserInteractionEnabled = true
        return image
    }()
    
    let countryLabel: UILabel = {
       let label = UILabel()
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        //label.text = "Northern Mariana Islands"
        label.font = UIFont(name: "Futura-Medium", size: 23)
        label.numberOfLines = 0
        return label
    }()
    
    var dataIndex = 0
    var country = ""
    var data: [CovidData] = []
    
    let dataView = CollectionView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        clickBackEvent()
        
        dataView.setData(covidData: data, index: dataIndex)
    }
    
    func configure() {
        self.view.addSubview(backButton)
        self.view.addSubview(countryLabel)
        self.view.addSubview(dataView)
        
        backButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(50)
            make.left.equalToSuperview().offset(20)
        }
        
        countryLabel.snp.makeConstraints { (make) in
            make.top.equalTo(backButton.snp.bottom).offset(20)
            make.left.equalTo(backButton.snp.left)
        }
        
        dataView.snp.makeConstraints { (make) in
            make.centerX.equalTo(view.snp.centerX)
            make.centerY.equalTo(view.snp.centerY).offset(-80)
            make.height.equalTo(300)
            make.left.equalToSuperview().offset(55)
            make.right.equalToSuperview().offset(-55)
        }
        
        countryLabel.text = country
    }
    
    func clickBackEvent() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(clickBackButton(sender:)))
        backButton.addGestureRecognizer(tapGesture)
    }
    
    @objc func clickBackButton(sender: UITapGestureRecognizer) {
        self.navigationController?.popViewController(animated: true)
    }

}
