//
//  WeatherMapViewController.swift
//  CityWeather
//
//  Created by 하연주 on 7/15/24.
//

import UIKit
import CoreLocation
import MapKit
import Toast

final class WeatherMapViewController : UIViewController {
    // MARK: - UI
    private let viewManager = WeatherMapView()
    
    // MARK: - Properties
    private let vm = WeatherMapViewModel()
    var navWillPop : ((Coord)->Void)?
    
    // MARK: - Lifecycle
    override func loadView() {
        view = viewManager
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindData()
        setupDelegate()
        addGesture()
    }
    
    // MARK: - Method
    private func bindData() {
        vm.outputIOSLocationServicesDisabled.bind(onlyCallWhenValueDidSet: true){[weak self] _ in
            guard let self else {return }
            self.showAlert(title: "위치 서비스 사용 허용하러 가기", message: nil, style: .alert) {
                self.goToLocationSettings()
            }
        }
        
        vm.outputDeviceLocationAuthorizationDenied.bind(onlyCallWhenValueDidSet: true) {[weak self] coordinate in
            guard let self, let coordinate else {return }
            self.setRegionCoordinator(center: coordinate)
        }
        
        vm.outputLongPressedPoint.bind(onlyCallWhenValueDidSet: true) {[weak self] pressedPoint in
            guard let self, let pressedPoint else {return }
            
            let coordinate = viewManager.mapView.convert(pressedPoint, toCoordinateFrom: viewManager.mapView)
            addAnnotation(coordinate : coordinate)
        }
    }

    
    // MARK: - SetupDelegate
    private func setupDelegate() {
        viewManager.mapView.delegate = self
        vm.locationManager.delegate = self
    }
    
    // MARK: - Gesture
    private func addGesture() {
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(viewTappedToGetCoordinate))
        view.addGestureRecognizer(longGesture)
    }
    
    @objc private func viewTappedToGetCoordinate(_ longGesture : UILongPressGestureRecognizer) {
        let touchPoint = longGesture.location(in: viewManager.mapView)
        vm.inputViewLongPressedGesturePoint.value = touchPoint
    }

    
    // MARK: - Location Related Method

    private func goToLocationSettings() {
        if let BUNDLE_IDENTIFIER = Bundle.main.bundleIdentifier,
            let url = URL(string: "\(UIApplication.openSettingsURLString)&path=LOCATION/\(BUNDLE_IDENTIFIER)") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    private func setRegionCoordinator(center : CLLocationCoordinate2D) {
        //MapKit
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 500, longitudinalMeters: 500)
        viewManager.mapView.setRegion(region, animated: true)
    }
    
    // MARK: - MapView Related Method
    private func addAnnotation(coordinate : CLLocationCoordinate2D) {
        view.makeToast("자세한 날씨를 알고싶다면 마커를 클릭하세요", duration: 2, position: .top)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        viewManager.mapView.addAnnotation(annotation)
    }

}


extension WeatherMapViewController : MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, didSelect annotation: any MKAnnotation) {
        navWillPop?(Coord(lon: annotation.coordinate.longitude, lat: annotation.coordinate.latitude))
        navigationController?.popViewController(animated: true)
    }
}





//위치 관련 프로토콜 채택 & 메서드 구현
extension WeatherMapViewController : CLLocationManagerDelegate{
    
    //1️⃣ 사용자의 권한 상태가 변경이 될 때 + 앱 다시 시작할 때(인스턴스 재생성될 때)에도 실행이 된다.
    //📌 iOS14 이상
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print("사용자의 권한 상태가 변경이 될 때 + 앱 다시 시작할 때 실행", #function)
        //기기의 위치 서비스 허용 여부부터 다시 확인 시작한다
        vm.inputCheckDeviceLocationAuthorization.value = ()
        
    }
    //📌 iOS14 미만
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("사용자의 권한 상태가 변경이 될 때 + 앱 다시 시작할 때 실행", #function)
        //기기의 위치 서비스 허용 여부부터 다시 확인 시작한다
        vm.inputCheckDeviceLocationAuthorization.value = ()
    }

    
    
    //2️⃣-1️⃣ 사용자 위치를 성공적으로 가지고 온 경우
    //여러번 호출될 수 있다 -> stopUpdatingLocation() 호출 필요
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //locations가 배열로 있다
        print("사용자 위치를 성공적으로 가지고 온 경우",#function)
        
        view.makeToast("날씨를 알고 싶은 위치를 길게 누르세요", duration: 5, position: .top)
        if let coordinate = locations.last?.coordinate {
            setRegionCoordinator(center: CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude))
        }
    
        vm.locationManager.stopUpdatingLocation()
        
    }
    
    //2️⃣-2️⃣ 사용자의 위치를 가지고 오지 못했을 때
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print("사용자의 위치를 가지고 오지 못했을 경우",#function)
        view.makeToast("사용자의 위치를 가져올 수 없습니다.")
    }
    

}
