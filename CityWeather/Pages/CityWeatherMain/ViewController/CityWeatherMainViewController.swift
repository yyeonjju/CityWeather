//
//  CityWeatherMainViewController.swift
//  CityWeather
//
//  Created by 하연주 on 7/10/24.
//

import UIKit

final class CityWeatherMainViewController : UIViewController {
    // MARK: - UI
    let viewManager = CityWeatherMainView()
    // MARK: - Properties
    
    // MARK: - Lifecycle
    override func loadView() {
        view = viewManager
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureToolbar()
        setupDelegate()
        
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
    
    
    // MARK: - AddTarget
    private func setupAddTarget() {
    }
    // MARK: - EventSelector
    @objc private func toolbarListButtonTapped() {
        print("리스트 버튼 클릭")
    }
    @objc private func toolbarmapButtonTapped() {
        print("맵 버튼 클릭")
    }
    
    // MARK: - SetupUI
    // MARK: - APIFetch
    // MARK: - PageTransition
}

extension CityWeatherMainViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FiveDaysForecastTableViewCell.description(), for: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "5일 간의 일기예보"
    }
}


extension CityWeatherMainViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EverythreeHoursForecastCollectionViewCell.description(), for: indexPath)
        
        return cell
    }

}
