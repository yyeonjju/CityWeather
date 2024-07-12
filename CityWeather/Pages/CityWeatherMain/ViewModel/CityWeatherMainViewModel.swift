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
    //viewDidLoad 시점에 넘겨받은 city에 대한 현재날씨 / 3시간/ 5일 데이터 받기
    var inputViewDidLoadTrigger : Observable<Void?> = Observable(nil)
    
    //output
    //현재 날씨 데이터
    var outputCurrentWeather : Observable<CurrentWeather?> = Observable(nil)
    var outputWeatherForecast : Observable<WeatherForecast?> = Observable(nil)
    var todayMaxMinTmep : Observable<(String?, String?)> = Observable((nil, nil))
    
    
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
                if time == "03:00:00" {
                    dailyMaxMinDict[day]!.iconID = item.weather.first?.icon ?? ""
                }
                
            }
        }
        return dailyMaxMinDict
    }
    
    
    init() {
        inputViewDidLoadTrigger.bind(onlyCallWhenValueDidSet: true) {[weak self] _ in
            guard let self else {return }
            self.getCurrentWeatherData()
            self.getWeatherForecastData()
        }
    }
    
    
    private func getCurrentWeatherData() {
        APIFetcher.shared.getCurrenWeather(lat: "37.583328", lon: "127.0") { [weak self] value, error in
            guard let self else {return }
            self.outputCurrentWeather.value = value
        }
    }
    
    private func getWeatherForecastData() {
        APIFetcher.shared.getWeatherForecast(lat: "37.583328", lon: "127.0") { [weak self] value, error in
            guard let self else {return }
            self.outputWeatherForecast.value = value
        }
    }
    
}
