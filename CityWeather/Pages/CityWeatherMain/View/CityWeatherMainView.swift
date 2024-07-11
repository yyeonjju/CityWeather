//
//  CityWeatherMainView.swift
//  CityWeather
//
//  Created by 하연주 on 7/10/24.
//

import UIKit
import SnapKit

final class CityWeatherMainView : BaseView {
    // MARK: - UI
    
    let cityNameLabel = {
        let label = UILabel()
        label.text = "Jeju City"
        label.font = .systemFont(ofSize: 40)
        label.textAlignment = .center
        return label
    }()
    
    let currentTemperatureLabel = {
        let label = UILabel()
        label.text = "5.9"
        label.font = .systemFont(ofSize: 80, weight: .ultraLight)
        label.textAlignment = .center
        return label
    }()
    
    let currentWeatherDescriptionLabel = {
        let label = UILabel()
        label.text = "Broken Clouds"
        label.font = .systemFont(ofSize: 24)
        label.textAlignment = .center
        return label
    }()
    
    let maxMinTempLabel = {
        let label = UILabel()
        label.text = "최고 : 7.0 | 최저 : -4.2"
        label.font = .systemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
    
    let everythreeHoursForecastCollectionView = {
        let collectionViewLayout = configureCollectionVewLayout(scrollDirection: .horizontal, numberofItemInrow: 5, sectionSpacing : 0, height: 120)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        cv.backgroundColor = .clear
        return cv
    }()
    
    let fiveDaysForecastTableView = {
        let tv = UITableView()
        tv.backgroundColor = .green
        tv.rowHeight = 60
        tv.backgroundColor = .clear
        tv.separatorStyle = .singleLine
        tv.allowsSelection = false
        return tv
    }()
    
    // MARK: - ConfigureUI
    
    override func configureSubView() {
        [cityNameLabel, currentTemperatureLabel, currentWeatherDescriptionLabel, maxMinTempLabel, everythreeHoursForecastCollectionView, fiveDaysForecastTableView]
            .forEach{
                addSubview($0)
            }
    }
    
    override func configureLayout() {
        cityNameLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(10)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide.snp.horizontalEdges)
        }
        
        currentTemperatureLabel.snp.makeConstraints { make in
            make.top.equalTo(cityNameLabel.snp.bottom).offset(4)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
        }
        
        currentWeatherDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(currentTemperatureLabel.snp.bottom).offset(4)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
        }
        
        maxMinTempLabel.snp.makeConstraints { make in
            make.top.equalTo(currentWeatherDescriptionLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
        }
        
        everythreeHoursForecastCollectionView.snp.makeConstraints { make in
            make.top.equalTo(maxMinTempLabel.snp.bottom).offset(50)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(20)
            make.height.equalTo(120)
        }
        
        fiveDaysForecastTableView.snp.makeConstraints { make in
            make.top.equalTo(everythreeHoursForecastCollectionView.snp.bottom).offset(20)
            make.bottom.equalTo(safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(20)
        }
    }

}
