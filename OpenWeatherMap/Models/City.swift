//
//  City.swift
//  OpenWeatherMap
//
//  Created by Pradheep Rajendirane on 12/12/2017.
//  Copyright © 2017 Pradheep Rajendirane. All rights reserved.
//

import Foundation

struct City: Decodable {
    
    let id: Int
    let name: String
    let country: String
    
    static func loadFromFile(name: String) -> [City]? {
        
        if let path = Bundle.main.path(forResource: name, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let decoder = JSONDecoder()
                let city = try decoder.decode([City].self, from: data)
                
                return city
                
            } catch {
                // handle error
                print(error)
                return nil
            }
        } else {
            return nil
        }
    }
    
}
