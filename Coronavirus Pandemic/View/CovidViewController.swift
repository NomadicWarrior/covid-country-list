//
//  ViewController.swift
//  Coronavirus Pandemic
//
//  Created by Nomadic on 9/5/20.
//  Copyright © 2020 Nomadic. All rights reserved.
//

import UIKit
import Combine

class CovidViewController: UIViewController {

    var covidViewModel: CovidViewModel!
    var locations: [CovidLocation] = []
    var data: [CovidData] = []
    
    private let apiManager = ApiManager()
    private var locationSubscriber: AnyCancellable?
    private var dataSubscriber: AnyCancellable?
    
    private var canClickCell = false
    
    // Table
    let countiesTableView: UITableView = {
        let tbl = UITableView()
        tbl.register(CellView.self, forCellReuseIdentifier: CellView.identifier)
        tbl.separatorStyle = .none
        return tbl
    }()
    
    // Search
    let searchView = SearchView()
    var isSearhing = false
    var searchLocations: [CovidLocation] = []
    
    // Loading effect
    var replicatingLayer: CAReplicatorLayer!
    var sourceLayer: CALayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        covidViewModel = CovidViewModel(apiManager: apiManager, endpoint: .locationFetch)
        covidViewModel.fetchCovidLocation()
        observViewModelLocation()
        createView()
        setupAnimation()
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.hideKeyboardWhenTappedAround()
        searchView.searchBar.delegate = self
    }
    
    private func observViewModelLocation() {
        
        locationSubscriber = covidViewModel.covidLocation.sink(receiveCompletion: { (resultCompletion) in
            switch resultCompletion {
            case .failure(let error):
                print(error.localizedDescription)
            default: break
            }
        }, receiveValue: { (data) in
            DispatchQueue.main.async {
                self.locations = data
                self.covidViewModel = CovidViewModel(apiManager: self.apiManager, endpoint: .dataFetch)
                self.covidViewModel.fetchCovidData()
                self.observViewModelData()
            }
        })
    }
    
    private func observViewModelData() {
        
        locationSubscriber = covidViewModel.covidData.sink(receiveCompletion: { (resultCompletion) in
            switch resultCompletion {
            case .failure(let error):
                print(error.localizedDescription)
            default: break
            }
        }, receiveValue: { (data) in
            DispatchQueue.main.async {
                self.data = data
                self.stopAnimation()
                self.canClickCell = true
                self.countiesTableView.reloadData()
            }
        })
    }
}

extension CovidViewController: UITableViewDelegate, UITableViewDataSource {
    
    func createView() {
        countiesTableView.delegate = self
        countiesTableView.dataSource = self
        countiesTableView.separatorStyle = .none
        
        
        self.view.addSubview(countiesTableView)
        self.view.addSubview(searchView)
        
        searchView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(50)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalTo(countiesTableView.snp.top)
            make.height.equalTo(60)
        }
        
        countiesTableView.snp.makeConstraints { (make) in
            make.top.equalTo(searchView.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearhing {
            return searchLocations.count
        }
        else {
            return locations.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellView.identifier, for: indexPath) as! CellView
        cell.selectionStyle = .none
        if isSearhing {
            cell.countryLabel.text = searchLocations[indexPath.row].locations
        }
        else {
            cell.countryLabel.text = locations[indexPath.row].locations
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var selectedIndex:Int = 0
        
        if canClickCell {
            if isSearhing {
                if let cellIndex = locations.firstIndex(where: { $0.locations == searchLocations[indexPath.row].locations }) {
                    selectedIndex = cellIndex
                }
            }
            else {
                if let cellIndex = locations.firstIndex(where: { $0.locations == locations[indexPath.row].locations}) {
                    selectedIndex = cellIndex
                }
            }
        openDetailVew(index: selectedIndex)
        }
    }
    
    func openDetailVew(index: Int) {
        let vc = self.storyboard?.instantiateViewController(identifier: "detail") as! DetailViewController
        vc.dataIndex = index
        vc.country = locations[index].locations
        vc.data = data
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension CovidViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchLocations = locations
        if searchText != "" {
            searchLocations = locations.filter({ $0.locations.contains(searchText)})
            isSearhing = true
        }
        countiesTableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearhing = false
        searchBar.text = ""
        countiesTableView.reloadData()
    }
}

extension CovidViewController {
    
    func setupAnimation () {
        replicatingLayer = CAReplicatorLayer()
        sourceLayer = CALayer()
        
        self.view.layer.addSublayer(replicatingLayer)
        replicatingLayer.addSublayer(sourceLayer)
        
        startAnimation(delay: 0.1, replicates: 15)
    }
    
    override func viewWillLayoutSubviews() {
        replicatingLayer.frame = self.view.bounds
        replicatingLayer.position = self.view.center
        
        sourceLayer.frame = CGRect(x: 0.0, y: 0.0, width: 3, height: 17)
        sourceLayer.backgroundColor = #colorLiteral(red: 0, green: 0.3285208941, blue: 0.5748849511, alpha: 1)
        sourceLayer.position = self.view.center
        sourceLayer.anchorPoint = CGPoint(x: 0.0, y: 5.0)
    }
    
    func startAnimation(delay: TimeInterval, replicates: Int) {
        
        replicatingLayer.instanceCount = replicates
        let angle = CGFloat(2.0 * Double.pi) / CGFloat(replicates)
        replicatingLayer.instanceTransform = CATransform3DMakeRotation(angle, 0.0, 0.0, 1.0)
        replicatingLayer.instanceDelay = delay
        
        sourceLayer.opacity = 0
        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.fromValue = 1
        opacityAnimation.toValue = 0
        opacityAnimation.duration = Double(replicates) * delay
        opacityAnimation.repeatCount = Float.infinity
        
        sourceLayer.add(opacityAnimation, forKey: nil)
    }
    
    func stopAnimation() {
        replicatingLayer.removeFromSuperlayer()
        sourceLayer.removeFromSuperlayer()
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

