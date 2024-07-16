//
//  CityWeatherMainViewModel.swift
//  CityWeather
//
//  Created by 하연주 on 7/11/24.
//

import Foundation

struct DailyMaxMinTempData {
    var maxTemp : Double
    var minTemp : Double
    var iconID : String
}

final class CityWeatherMainViewModel {
    //input
    //위경도 좌표 정보를 in
    var inputCoordinates : Observable<Coord?> = Observable(nil)
    
    //output
    //현재 날씨 데이터
    var outputCurrentWeather : Observable<CurrentWeather?> = Observable(nil)
    //날씨 예보 데이터
    var outputWeatherForecast : Observable<WeatherForecast?> = Observable(nil)
    //에러
    var outputCurrentWeatherRequestErrorMessage : Observable<String?> = Observable(nil)
    var outputForecastRequestErrorMessage : Observable<String?> = Observable(nil)
    
    
    var DailyMaxMinTempList : [String : DailyMaxMinTempData] {
        guard let forcastList = outputWeatherForecast.value?.list else {return [:]}
        var dailyMaxMinDict :[String : DailyMaxMinTempData] = [:]
        for item in forcastList {
            let day = item.dtTxt.components(separatedBy: " ")[0]
            let time = item.dtTxt.components(separatedBy: " ")[1]
            
            if dailyMaxMinDict[day] == nil {
                dailyMaxMinDict[day] = DailyMaxMinTempData(maxTemp: item.main.tempMax, minTemp: item.main.tempMin, iconID: item.weather.first?.icon ?? "")
            } else {
                if dailyMaxMinDict[day]!.maxTemp < item.main.tempMax {
                    dailyMaxMinDict[day]!.maxTemp = item.main.tempMax
                }
                if dailyMaxMinDict[day]!.minTemp > item.main.tempMin {
                    dailyMaxMinDict[day]!.minTemp = item.main.tempMin
                }
                
                let localTimeString = DateFormatManager.shared.convertSpecificZoneStringToLocalZoneString(SpecificTimeZoneFormatter: .utcZoneTime, SpecificZoneString: time, fromFormat: .time, toFormat: .time)
                if localTimeString == "12:00:00" {
                    dailyMaxMinDict[day]!.iconID = item.weather.first?.icon ?? ""
                }
                
            }
        }
        return dailyMaxMinDict
    }
    
    
    init() {
        inputCoordinates.bind(onlyCallWhenValueDidSet: true) {[weak self] value in
            guard let self, let value else {return }
            self.getCurrentWeatherData(coordinates: value)
            self.getWeatherForecastData(coordinates: value)
        }
    }
    
    
    private func getCurrentWeatherData(coordinates : Coord) {
        APIFetcher.shared.getCurrenWeather(lat: String(coordinates.lat), lon: String(coordinates.lon)) { [weak self] result in
            guard let self else {return }
            
            switch result {
            case .success(let value):
                self.outputCurrentWeather.value = value
            case .failure(let error):
                self.outputCurrentWeatherRequestErrorMessage.value = error.errorMessage
            }
        }
    }
    
    private func getWeatherForecastData(coordinates : Coord) {
        APIFetcher.shared.getWeatherForecast(lat: String(coordinates.lat), lon: String(coordinates.lon)) { [weak self] result in
            guard let self else {return }
            
            switch result {
            case .success(let value):
                self.outputWeatherForecast.value = value
            case .failure(let error):
                self.outputForecastRequestErrorMessage.value = error.errorMessage
            }


        }
    }
    
}
