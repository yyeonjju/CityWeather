//
//  WeatherMapViewModel.swift
//  CityWeather
//
//  Created by 하연주 on 7/15/24.
//

import Foundation
import CoreLocation

final class WeatherMapViewModel {
    let locationManager = CLLocationManager()
    
    //input
    //위치 권한 확인
    var inputCheckDeviceLocationAuthorization : Observable<Void?> = Observable(nil)
    
    //output
    //iOS 위치 서비스 활성화 안 되어 있을 때
    var outputIOSLocationServicesDisabled : Observable<Void?> = Observable(nil)
    //사용자 위치 권한이 거부되었을 때
    var outputDeviceLocationAuthorizationDenied : Observable<CLLocationCoordinate2D?> = Observable(nil)
    
    
    
    init() {
        inputCheckDeviceLocationAuthorization.bind(onlyCallWhenValueDidSet: true) { [weak self] _ in
            guard let self else {return }
            self.checkDeviceLocationAuthorization()
        }
    }
    
    
    
    //locationManagerDidChangeAuthorization 시점에
    //iOS 위치 서비스 활성화 여부 체크
    func checkDeviceLocationAuthorization () {

        //해당경고 때문에 DispatchQueue.global().async
        //This method can cause UI unresponsiveness if invoked on the main thread. Instead, consider waiting for the `-locationManagerDidChangeAuthorization:` callback and checking `authorizationStatus` first.
        
        DispatchQueue.global().async {[weak self] in
            if CLLocationManager.locationServicesEnabled() {
                print("ios위치 서비스 사용할 수 있음! -> 디바이스의 위치 권한 체크")
                DispatchQueue.main.async {
                    self?.checkCurrentLocationAuthorization()
                }
            }else {
                
                print("ios위치 서비스 사용할 수 없음 -> 얼럿 띄워 iOS 설정으로 가도록")
                DispatchQueue.main.async {
                    self?.outputIOSLocationServicesDisabled.value = ()
                }
            }
        }
        
    }
    
    
    //locationManagerDidChangeAuthorization 시점에
    // 현재 사용자 위치 권한 상태 확인
    func checkCurrentLocationAuthorization () {
        var status : CLAuthorizationStatus
        
        if #available(iOS 14.0, *) {
            status = locationManager.authorizationStatus
        }else {
            status = CLLocationManager.authorizationStatus()
        }
    
        
        switch status {
        case .notDetermined:
            print("notDetermined - 설정하지 않았을 때")
            // 업데이트 주기 설정
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
        case .denied:
            print("denied - 권한 거부하면 다른 곳 띄워주기")
            //임의의 위치로 띄워주기
            outputDeviceLocationAuthorizationDenied.value = CLLocationCoordinate2D(latitude: 37.517597, longitude: 126.887247)
            
        case .authorizedWhenInUse:
            print("authorizedWhenInUse")
            locationManager.startUpdatingLocation() //->didUpdateLocations을 불러준다
        default :
            print("🎀🎀🎀",status)
        }
    }
    
    
    
    
}
