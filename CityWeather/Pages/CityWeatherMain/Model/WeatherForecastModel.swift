//
//  WeatherForecastModel.swift
//  CityWeather
//
//  Created by 하연주 on 7/12/24.
//

import Foundation


struct WeatherForecast : Decodable {
    let cod: String
    let list : [Forecast]
    let city : City
}

struct City : Decodable {
    let id : Int
    let name : String
    let coord : Coord
}

struct Forecast : Decodable {
    let main : Main
    let weather : [Weather]
    let dtTxt : String
    
    enum CodingKeys: String, CodingKey{
        case main
        case weather
        case dtTxt = "dt_txt"
    }
    
    
    var temparatureText : String {
        get{"\(Int(main.temp))°"}
    }
    var timeText : String {
        get{
            let localDateString = DateFormatManager.shared.convertSpecificZoneStringToLocalZoneString(SpecificTimeZoneFormatter: .utcZoneTime, SpecificZoneString: dtTxt, fromFormat: .dateAndTime, toFormat: .hour)
        return "\(localDateString)시"
        }
    }
    
    var iconImageURL : String {
        guard let iconID = weather.first?.icon else {return  ""}
        return "\(APIURL.iconImageURL)\(iconID)\(APIURL.iconImageURLSuffix)"
    }
    
}
