//
//  CityForecast.swift
//  OpenWeatherMap
//
//  Created by Pradheep Rajendirane on 12/12/2017.
//  Copyright © 2017 Pradheep Rajendirane. All rights reserved.
//

import Foundation

struct CityForecast: Decodable {
    
    let cod: String
    let city: City
    let list:[Forecast]
    
    // API endpoint for CityForecast
    static func endpointForID(_ id: Int, units: Units) -> String {
        return "\(apiMainEndpoint)forecast?appid=\(apikey)&id=\(id)&units=\(units)"
    }
    
    /* ==========
    Static function to get the units string depending the API units
     parameter:
     - units (Units) : the web service parameters
     return:
     - String : the user readable unit (C,F or K) (Celcius, Farenheit or Kelvin)
    ========== */
    static func stringForUnits(_ units: Units) -> String {
        switch units {
        case .imperial:
            return "F"
        case .metric:
            return "C"
        case .standard:
            return "K"
        }
    }
    
    /* ==========
     static function to init a CityForecast object from the API given the cityID (Int) and the units (Units). The call to the web service is executed in the background thread.
     parameters:
     - id (Int) : City Id
     - units (Units) : units (default: standard)
     completionHandler :
     - CityForecast (optional) : if all goes well, the completionHandler provide the CityForecast object
     - Error (optional) : if error, the completionHandler provide the error object
    ========== */
    static func cityForecastById(_ id: Int, units: Units, completionHandler: @escaping (CityForecast?, Error?) -> Void) {
        
        // set up URLRequest with URL
        let endpoint = CityForecast.endpointForID(id, units: units)
        guard let url = URL(string: endpoint) else {
            let error = BackendError.urlError(reason: "Could not construct URL")
            completionHandler(nil, error)
            return
        }
        let urlRequest = URLRequest(url: url)
        
        // Make request
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest, completionHandler: {
            (data, response, error) in
            // handle response to request
            // check for error
            guard error == nil else {
                completionHandler(nil, error!)
                return
            }
            // make sure we got data in the response
            guard let responseData = data else {
                let error = BackendError.objectSerialization(reason: "No data in response")
                completionHandler(nil, error)
                return
            }
            
            // parse the result as JSON
            // then create a CityForecast from the JSON
            let decoder = JSONDecoder()
            do {
                let cityForecast = try decoder.decode(CityForecast.self, from: responseData)
                completionHandler(cityForecast, nil)
            } catch {
                completionHandler(nil, error)
            }
        })
        task.resume()
    }
    
    
}


enum BackendError: Error {
    case urlError(reason: String)
    case objectSerialization(reason: String)
}
