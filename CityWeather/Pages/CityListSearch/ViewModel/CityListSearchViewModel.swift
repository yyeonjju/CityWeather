//
//  CityListSearchViewModel.swift
//  CityWeather
//
//  Created by 하연주 on 7/13/24.
//

import Foundation

final class CityListSearchViewModel {
    //전체 도시 리스트 저장해둠
    private var cityList : [CityInfo] = []
    
    //input
    var inputViewDidLoadTrigger : Observable<Void?> = Observable(nil)
    //검색 버튼 눌렀을 때
    var inputSearchKeyword : Observable<String?> = Observable(nil)
    
    
    //output
    //테이블뷰에 띄워줄 도시 리스트
    var outputCityList : Observable<[CityInfo]?> = Observable(nil)
    
    
    
    init() {
        inputViewDidLoadTrigger.bind(onlyCallWhenValueDidSet: true) {[weak self] _ in
            guard let self else {return }
            self.getCityListData()
        }
        
        inputSearchKeyword.bind(onlyCallWhenValueDidSet: true) {[weak self] value in
            guard let self, let value else {return }
            self.searchCity(keyword: value)
        }
    }
    
    
    
    private func getCityListData() {
        fetchMockData(fileName : "CityList", model : [CityInfo].self){ [weak self] value in
            guard let self else{return }
            self.cityList = value
            self.outputCityList.value = cityList
        }
    }
    
    private func searchCity(keyword : String) {
        if isOnlyWhitespace(keyword) {
            outputCityList.value = cityList
        }else {
            outputCityList.value = cityList.filter{
                $0.name.lowercased().contains(keyword.lowercased())
            }
        }
    }
    
}
