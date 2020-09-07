//
//  CovidViewModel.swift
//  Coronavirus Pandemic
//
//  Created by Nomadic on 9/5/20.
//  Copyright © 2020 Nomadic. All rights reserved.
//

import Foundation
import Combine

class CovidViewModel {
    
    // Dependency injection
    private let apiManager: ApiManager
    private let endpoint: Endpoint
    
    var covidData = PassthroughSubject<[CovidData], Error>()
    var covidLocation = PassthroughSubject<[CovidLocation], Error>()
    
    init(apiManager: ApiManager, endpoint: Endpoint) {
        self.apiManager = apiManager
        self.endpoint = endpoint
    }
    
    func fetchCovidLocation() {
        let url = URL(string: endpoint.urlString)!
        apiManager.fetchItems(url: url) { [weak self](result: Result<[CovidLocation], Error>) in
            switch result {
            case .success(let locations):
                self?.covidLocation.send(locations)
            case .failure(let error):
                self?.covidLocation.send(completion: .failure(error))
            }
        }
    }
    
    func fetchCovidData() {
        let url = URL(string: endpoint.urlString)!
        apiManager.fetchItems(url: url) { [weak self](result: Result<[CovidData], Error>) in
            switch result {
            case .success(let data):
                self?.covidData.send(data)
            case .failure(let error):
                self?.covidData.send(completion: .failure(error))
            }
        }
    }
}
