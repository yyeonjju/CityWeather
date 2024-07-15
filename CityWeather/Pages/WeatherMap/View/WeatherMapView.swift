//
//  WeatherMapView.swift
//  CityWeather
//
//  Created by 하연주 on 7/15/24.
//

import UIKit
import SnapKit
import MapKit

final class WeatherMapView : UIView {
    // MARK: - UI
//    let label = {
//        let label = UILabel()
//        label.text = "위치"
//        return label
//    }()
    
    let mapView = {
        let map = MKMapView()
        return map
    }()
    
    
    // MARK: - Initializer
    
    override init(frame : CGRect) {
        super.init(frame: frame)
        
        configureSubView()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - ConfigureUI
    
    private func configureSubView() {
        [mapView]
            .forEach{
                addSubview($0)
            }
    }
    
    private func configureLayout() {
        mapView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }

}
