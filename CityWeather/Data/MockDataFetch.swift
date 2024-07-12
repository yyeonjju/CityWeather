//
//  MockDataFetch.swift
//  CityWeather
//
//  Created by 하연주 on 7/13/24.
//

import Foundation

fileprivate func loadData(fileName : String) -> Data? {
    // 1. 불러올 파일 이름
    let fileNm: String = fileName
    // 2. 불러올 파일의 확장자명
    let extensionType = "json"
    
    // 3. 파일 위치
    guard let fileLocation = Bundle.main.url(forResource: fileNm, withExtension: extensionType) else { return nil }
    
    do {
        // 4. 해당 위치의 파일을 Data로 초기화하기
        let data = try Data(contentsOf: fileLocation)
        return data
    } catch {
        // 5. 잘못된 위치나 불가능한 파일 처리 (오늘은 따로 안하기)
        return nil
    }
}


func fetchMockData<T:Decodable>(fileName : String ,model: T.Type, handler : @escaping (T) -> Void ) {
    DispatchQueue.global().asyncAfter(deadline: .now() + 1.5) {

        guard let data = loadData(fileName : fileName) else {return }

        do {
            let value = try JSONDecoder().decode( T.self, from: data)
            DispatchQueue.main.async {
                handler(value)
            }
        } catch {
            
        }
    }
}
