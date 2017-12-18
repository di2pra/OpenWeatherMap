//
//  Weather.swift
//  OpenWeatherMap
//
//  Created by Pradheep Rajendirane on 14/12/2017.
//  Copyright © 2017 Pradheep Rajendirane. All rights reserved.
//

import Foundation

struct Weather: Decodable {
    
    let id: Int
    let main: String
    let description: String
    let icon: String
    
}
