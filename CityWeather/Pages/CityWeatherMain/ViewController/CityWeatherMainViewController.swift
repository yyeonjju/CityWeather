//
//  CityWeatherMainViewController.swift
//  CityWeather
//
//  Created by 하연주 on 7/10/24.
//

import UIKit
import Toast

final class CityWeatherMainViewController : UIViewController {
    // MARK: - UI
    let viewManager = CityWeatherMainView()
    // MARK: - Properties
    let vm = CityWeatherMainViewModel()
    
    // MARK: - Lifecycle
    override func loadView() {
        view = viewManager
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureToolbar()
        setupDelegate()
        bindData()
        
    }
    // MARK: - BindData
    private func bindData() {
        vm.inputCoordinates.value = Coord(lon: 127.0, lat: 37.583328)
        
        
        vm.outputCurrentWeather.bind {[weak self] value in
            guard let self, let value else {return }
            setupCurrentWeatherData(data : value)
        }
        
        vm.outputWeatherForecast.bind {[weak self] _ in
            guard let self else {return }
            viewManager.everythreeHoursForecastCollectionView.reloadData()
            viewManager.fiveDaysForecastTableView.reloadData()
        }
        
        vm.outputCurrentWeatherRequestErrorMessage.bind {[weak self] value in
            guard let self, let value else {return }
            self.view.makeToast("현재 날씨 정보를 가져오지 못했습니다 : \(value)")
        }
        
        vm.outputForecastRequestErrorMessage.bind {[weak self] value in
            guard let self, let value else {return }
            self.view.makeToast("날씨예보 정보를 가져오지 못했습니다 : \(value)")
        }
        
    }

    
    // MARK: - ConfigureToolbar
    private func configureToolbar () {
        
        let list = UIBarButtonItem(image: UIImage(systemName: "list.bullet"), style: .plain, target: self, action: #selector(toolbarListButtonTapped))
        let space =  UIBarButtonItem(systemItem: .flexibleSpace)
        let map = UIBarButtonItem(image: UIImage(systemName: "map"), style: .plain, target: self, action: #selector(toolbarmapButtonTapped))
        list.tintColor = Assets.Color.white
        map.tintColor = Assets.Color.white
        
        toolbarItems = [map, space, list]
        navigationController?.setToolbarHidden(false, animated: false)
    }

    
    // MARK: - SetupDelegate
    private func setupDelegate() {
        
        viewManager.everythreeHoursForecastCollectionView.delegate = self
        viewManager.everythreeHoursForecastCollectionView.dataSource = self
        viewManager.everythreeHoursForecastCollectionView.register(EverythreeHoursForecastCollectionViewCell.self, forCellWithReuseIdentifier: EverythreeHoursForecastCollectionViewCell.description())
        
        viewManager.fiveDaysForecastTableView.delegate = self
        viewManager.fiveDaysForecastTableView.dataSource = self
        viewManager.fiveDaysForecastTableView.register(FiveDaysForecastTableViewCell.self, forCellReuseIdentifier: FiveDaysForecastTableViewCell.description())
        
    }
    
    // MARK: - EventSelector
    @objc private func toolbarListButtonTapped() {
        let vc = CityListSearchViewController()
        vc.navWillPop = {[weak self] coordinates in
            guard let self else {return }
            self.vm.inputCoordinates.value = Coord(lon: coordinates.lon, lat: coordinates.lat)
        }
        pageTransition(to: vc, type: .push)
    }
    @objc private func toolbarmapButtonTapped() {
        let vc = WeatherMapViewController()
        vc.navWillPop = {[weak self] coordinates in
            guard let self else {return }
            self.vm.inputCoordinates.value = Coord(lon: coordinates.lon, lat: coordinates.lat)
        }
        pageTransition(to: vc, type: .push)
    }
    
    // MARK: - Method
    private func setupCurrentWeatherData(data : CurrentWeather) {
        viewManager.cityNameLabel.text = data.name
        viewManager.maxMinTempLabel.text = data.maxMinTempText
        viewManager.currentTemperatureLabel.text = data.currentTempText
        guard let weather = data.weather.first else {return }
        viewManager.currentWeatherDescriptionLabel.text = weather.description

    }

    
    // MARK: - SetupUI
    // MARK: - APIFetch
    // MARK: - PageTransition
    
}

extension CityWeatherMainViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.DailyMaxMinTempList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FiveDaysForecastTableViewCell.description(), for: indexPath) as! FiveDaysForecastTableViewCell

        let data = vm.DailyMaxMinTempList.sorted{$0.key < $1.key}[indexPath.row]
        cell.configureData(data: DayMaxMinData(dateString: data.key, maxTemp: data.value.maxTemp, minTemp: data.value.minTemp, iconID: data.value.iconID))
        return cell
    }
    
}


extension CityWeatherMainViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let forecast = vm.outputWeatherForecast.value else {return 0}
        return forecast.list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EverythreeHoursForecastCollectionViewCell.description(), for: indexPath) as! EverythreeHoursForecastCollectionViewCell
        guard let forecast = vm.outputWeatherForecast.value else {return cell}
        let data = forecast.list[indexPath.row]
        cell.configureData(data: data)
        return cell
    }

}
