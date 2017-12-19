//
//  Forecast.swift
//  OpenWeatherMap
//
//  Created by Pradheep Rajendirane on 12/12/2017.
//  Copyright © 2017 Pradheep Rajendirane. All rights reserved.
//

import Foundation

struct Forecast {

    let dt: Date
    let dt_txt: String
    let temp:Double
    let temp_min:Double? // optional
    let temp_max:Double? // optional
    let weather:[Weather]
    
    enum CodingKeys: String, CodingKey {
        case dt
        case dt_txt
        case weather
        case main
    }
    
    enum MainKeys: String, CodingKey {
        case temp
        case temp_min
        case temp_max
    }
}

extension Forecast: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        // catch the unix timestamp and parse to Date
        let unixDt = try values.decode(Int.self, forKey: .dt)
        dt = Date(timeIntervalSince1970: TimeInterval(unixDt))
        
        dt_txt = try values.decode(String.self, forKey: .dt_txt)
        weather = try values.decode([Weather].self, forKey: .weather)
        
        let main = try values.nestedContainer(keyedBy: MainKeys.self, forKey: .main)
        temp = try main.decode(Double.self, forKey: .temp)
        temp_min = try main.decode(Double.self, forKey: .temp_min)
        temp_max = try main.decode(Double.self, forKey: .temp_max)
    }
}
