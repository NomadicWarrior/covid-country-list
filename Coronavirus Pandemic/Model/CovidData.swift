//
//  CovidData.swift
//  Coronavirus Pandemic
//
//  Created by Nomadic on 9/5/20.
//  Copyright © 2020 Nomadic. All rights reserved.
//


import Foundation


struct CovidData: Decodable {
    let cases: String
    let deaths: String
    let recov: String
}

struct CovidLocation: Decodable {
    let locations: String
}

enum Endpoint {
    case dataFetch
    case locationFetch
    
    var urlString: String {
        switch self {
        case .dataFetch:
            return "https://brainstorm-unity.000webhostapp.com/covid-19-results.php"
        case .locationFetch:
            return "https://brainstorm-unity.000webhostapp.com/locations.php"
        }
    }
}
