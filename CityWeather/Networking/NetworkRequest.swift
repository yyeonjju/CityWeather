//
//  NetworkRequest.swift
//  CityWeather
//
//  Created by 하연주 on 7/12/24.
//

import Foundation

enum NetworkRequest {
    case currentWeather(lat : String, lon : String)
    case weatherForecast(lat : String, lon : String)
    
    private var baseURL : String{
        return "\(APIURL.scheme)://\(APIURL.host)/\(APIURL.version)/"
    }
    
    var endpoint : String {
        switch self {
        case .currentWeather:
            return baseURL + APIURL.currentWeather
        case .weatherForecast:
            return baseURL + APIURL.weatherForecast
        }
    }
    
    var method : String {
        return "GET"
        
    }
    
    var parameters : [String : String] {
        switch self {
        case .currentWeather(let lat, let lon), .weatherForecast(let lat, let lon) :
            return ["lat" : lat, "lon" : lon, "units" : "metric" ,"appid" : APIKey.openWeatherMapKey]
            
        }
    }
    
    var headers : [String : String] {
        switch self {
        case .currentWeather, .weatherForecast:
            return [:]
        }
    }
    
}
