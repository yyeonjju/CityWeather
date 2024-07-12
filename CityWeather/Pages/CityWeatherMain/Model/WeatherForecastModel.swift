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
            let utcZoneDate = DateFormatManager.shared.getDateFormatter(formatterType : .utcZoneTime, format: .dateAndTime).date(from: dtTxt)
            guard let utcZoneDate else {return "-"}
            let krDateString = DateFormatManager.shared.getDateFormatter(formatterType: .krLocaleTime , format: .hour).string(from: utcZoneDate)
        return "\(krDateString)시"
        }
    }
    
    var iconImageURL : String {
        guard let iconID = weather.first?.icon else {return  ""}
        return "\(APIURL.iconImageURL)\(iconID)\(APIURL.iconImageURLSuffix)"
    }
    
}
