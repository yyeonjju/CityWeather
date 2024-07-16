//
//  APIFetcher.swift
//  CityWeather
//
//  Created by 하연주 on 7/12/24.
//

import Foundation



protocol APIFetchable {
    func getCurrenWeather(lat : String, lon : String, handler : @escaping (Result<CurrentWeather, RequestError>) ->Void) -> Void
    func getWeatherForecast(lat : String, lon : String, handler: @escaping (Result<WeatherForecast, RequestError>) -> Void)
}


class APIFetcher {
    static let shared = APIFetcher()
    private init(){}
    
//    typealias completionHandler<T:Decodable, E: Error> = Result<T,E>
    
    private func getSingle<T : Decodable>(
        model : T.Type,
        requestType : NetworkRequest,
        completionHandler : @escaping (Result<T, RequestError>) -> Void
    ) {
        ///URLComponents
        guard var component = URLComponents(string: requestType.endpoint) else {return }
        let queryItemArray = requestType.parameters.map {
            URLQueryItem(name: $0.key, value: $0.value)
        }
        component.queryItems = queryItemArray
        
        ///URLRequest
        guard let url = component.url else {return  completionHandler(.failure(.url))}
        var request = URLRequest(url: url)
        
        request.httpMethod = requestType.method
        requestType.headers.forEach { (key, value) in
            request.addValue(key, forHTTPHeaderField: value)
        }
        
        ///dataTask
        URLSession.shared.dataTask(with: request) {data, response, error in
            
            DispatchQueue.main.async {
                
                guard error == nil else {
                    completionHandler(.failure(.failedRequest))
                    return
                }
                
                guard let data else {
                    completionHandler(.failure(.noData))
                    return
                }
                
                guard let response = response as? HTTPURLResponse else {
                    completionHandler(.failure(.invalidResponse))
                    return
                }
                
                guard response.statusCode == 200 else {
                    var errorMessage: String?
                    if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: String] {
                        errorMessage = json["errorMessage"]
                    }
                    completionHandler(.failure(.failResponse(code: response.statusCode, message: errorMessage ?? "-")))

                    return
                }
                
                
                
                do {
                    let result = try JSONDecoder().decode(model.self, from: data)

                    completionHandler(.success(result))
                }catch {
                    completionHandler(.failure(.invalidData))
                }
            }

        }
        .resume()
    }
    
}


extension APIFetcher : APIFetchable{
    func getCurrenWeather(lat : String, lon : String, handler: @escaping (Result<CurrentWeather, RequestError>) -> Void) {
        let requestType = NetworkRequest.currentWeather(lat: lat, lon: lon)
        
        getSingle(model : CurrentWeather.self, requestType : requestType){ result in
            handler(result)
        }
    }
    
    func getWeatherForecast(lat : String, lon : String, handler: @escaping (Result<WeatherForecast, RequestError>) -> Void) {
        let requestType = NetworkRequest.weatherForecast(lat: lat, lon: lon)
        
        getSingle(model : WeatherForecast.self, requestType : requestType){ result in
            handler(result)
        }
    }
}
