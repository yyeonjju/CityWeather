//
//  CityWeatherMainViewModel.swift
//  CityWeather
//
//  Created by 하연주 on 7/11/24.
//

import Foundation

final class CityWeatherMainViewModel {
    //input
    //viewDidLoad 시점에 넘겨받은 city에 대한 현재날씨 / 3시간/ 5일 데이터 받기
    var inputViewDidLoadTrigger : Observable<Void?> = Observable(nil)
    
    //output
    //현재 날씨 데이터
    var outputCurrentWeather : Observable<CurrentWeather?> = Observable(nil)
    var outputWeatherForecast : Observable<WeatherForecast?> = Observable(nil)
    
    
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
            print("value, error❤️", value, error)
            self.outputCurrentWeather.value = value
        }
    }
    
    private func getWeatherForecastData() {
        APIFetcher.shared.getWeatherForecast(lat: "37.583328", lon: "127.0") { [weak self] value, error in
            guard let self else {return }
            print("value, error🎀", value, error)
            self.outputWeatherForecast.value = value
        }
    }
    
    
    
    
    
}
