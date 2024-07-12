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
        label.text = "- City"
        label.font = .systemFont(ofSize: 40)
        label.textAlignment = .center
        return label
    }()
    
    let currentTemperatureLabel = {
        let label = UILabel()
        label.text = "-°"
        label.font = .systemFont(ofSize: 80, weight: .ultraLight)
        label.textAlignment = .center
        return label
    }()
    
    let currentWeatherDescriptionLabel = {
        let label = UILabel()
        label.text = "-"
        label.font = .systemFont(ofSize: 24)
        label.textAlignment = .center
        return label
    }()
    
    let maxMinTempLabel = {
        let label = UILabel()
        label.text = "최고 : -° | 최저 : -°"
        label.font = .systemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
    
    
    let everythreeHoursForecastLabel = {
        let label = UILabel()
        label.attachIcon(image: UIImage(systemName: "calendar")!, direction: .leading, tintColor: Assets.Color.white,size: CGRect(x: 0, y: 0, width: 13, height: 13), text: " 3시간 간격의 일기예보", font: .systemFont(ofSize: 15))
        return label
    }()
    
    let everythreeHoursForecastCollectionView = {
        let collectionViewLayout = configureCollectionVewLayout(scrollDirection: .horizontal, numberofItemInrow: 5, sectionSpacing : 0, height: 120)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        cv.backgroundColor = .clear
        return cv
    }()
    
    let fiveDaysForecastLabel = {
        let label = UILabel()
        label.attachIcon(image: UIImage(systemName: "calendar")!, direction: .leading, tintColor: Assets.Color.white,size: CGRect(x: 0, y: 0, width: 13, height: 13), text: " 5일 간의 일기예보", font: .systemFont(ofSize: 15))
        return label
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
        [cityNameLabel, currentTemperatureLabel, currentWeatherDescriptionLabel, maxMinTempLabel, everythreeHoursForecastCollectionView, fiveDaysForecastTableView, everythreeHoursForecastLabel, fiveDaysForecastLabel]
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
        
        everythreeHoursForecastLabel.snp.makeConstraints { make in
            make.top.equalTo(maxMinTempLabel.snp.bottom).offset(50)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(20)
        }
        everythreeHoursForecastCollectionView.snp.makeConstraints { make in
            make.top.equalTo(everythreeHoursForecastLabel.snp.bottom).offset(4)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(20)
            make.height.equalTo(120)
        }
        
        fiveDaysForecastLabel.snp.makeConstraints { make in
            make.top.equalTo(everythreeHoursForecastCollectionView.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(20)
        }
        fiveDaysForecastTableView.snp.makeConstraints { make in
            make.top.equalTo(fiveDaysForecastLabel.snp.bottom).offset(4)
            make.bottom.equalTo(safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(20)
        }
    }

}
