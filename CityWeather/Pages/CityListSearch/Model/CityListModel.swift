//
//  CityListModel.swift
//  CityWeather
//
//  Created by 하연주 on 7/13/24.
//

import Foundation

struct CityInfo : Decodable {
    let id : Int
    let name, state, country : String
    let coord : Coord
}
