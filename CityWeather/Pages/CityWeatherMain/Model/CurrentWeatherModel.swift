//
//  CurrentWeatherModel.swift
//  CityWeather
//
//  Created by 하연주 on 7/12/24.
//

import Foundation


struct CurrentWeather : Decodable {
    let coord: Coord
    let weather: [Weather]
    let base: String
    let main: Main
    let visibility: Int
    let wind: Wind
    //    let clouds: Clouds
    let dt: Int
    let sys: Sys
    let timezone:Int
    let id: Int
    let name: String
    let cod: Int
    
    var maxMinTempText : String {
        get {return "최고 : \(main.tempMax) | 최저 : \(main.tempMin)"}
    }
}

struct Coord: Decodable {
    let lon: Double
    let lat: Double
}

struct Weather : Decodable {
    let id : Int
    let main, description, icon : String
}

struct Main: Codable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, humidity, seaLevel, grndLevel: Int
    
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
    }
}

struct Wind : Decodable {
    let speed: Double
    let deg: Int
}

struct Sys: Decodable {
    let type, id: Int
    let country: String
    let sunrise, sunset: Int
}
