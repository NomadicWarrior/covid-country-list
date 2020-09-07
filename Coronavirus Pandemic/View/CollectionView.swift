//
//  CollectionView.swift
//  Coronavirus Pandemic
//
//  Created by Nomadic on 9/6/20.
//  Copyright © 2020 Nomadic. All rights reserved.
//

import UIKit
import SnapKit

class CollectionView: UIView {
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.headerReferenceSize = CGSize(width: 15, height: 15)
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(DataCell.self, forCellWithReuseIdentifier: "cell")
        cv.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        cv.clipsToBounds = false
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()
    
    let dataTitles = ["CASES", "DEATHS", "RECOVERED", "🐶"]
    var dataResults = [String]()
    var data: [CovidData] = []
    
    
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
        addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    func setData(covidData: [CovidData], index: Int) {
        dataResults.append(covidData[index].cases)
        dataResults.append(covidData[index].deaths)
        dataResults.append(covidData[index].recov)
        dataResults.append("🐶")
        print(dataResults)
        collectionView.reloadData()
    }
}

extension CollectionView: UICollectionViewDelegate {
    
}

extension CollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataTitles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! DataCell
        cell.title.text = dataTitles[indexPath.row]
        cell.dataTitle.text = dataResults[indexPath.row]
        return cell
    }
}

extension CollectionView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 140, height: 140)
    }
}
