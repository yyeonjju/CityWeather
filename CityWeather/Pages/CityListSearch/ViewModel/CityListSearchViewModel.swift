//
//  CityListSearchViewModel.swift
//  CityWeather
//
//  Created by 하연주 on 7/13/24.
//

import Foundation

final class CityListSearchViewModel {
    //input
    var inputViewDidLoadTrigger : Observable<Void?> = Observable(nil)
    
    
    //output
    var outputCityList : Observable<[CityInfo]?> = Observable(nil)
    
    init() {
        inputViewDidLoadTrigger.bind(onlyCallWhenValueDidSet: true) {[weak self] _ in
            guard let self else {return }
            self.getCityListData()
        }
    }
    
    private func getCityListData() {
        fetchMockData(fileName : "CityList", model : [CityInfo].self){ [weak self] value in
            guard let self else{return }
            self.outputCityList.value = value
        }
    }
    
}
