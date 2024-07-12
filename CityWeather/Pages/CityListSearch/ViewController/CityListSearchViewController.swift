//
//  CityListSearchViewController.swift
//  CityWeather
//
//  Created by 하연주 on 7/13/24.
//

import UIKit

final class CityListSearchViewController : UIViewController {
    // MARK: - UI
    private let viewManager = CityListSearchView()
    // MARK: - Properties
    private let vm = CityListSearchViewModel()
    // MARK: - Lifecycle
    override func loadView() {
        view = viewManager
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBackButtonItem()
        setupDelegate()
        bindData()
    }
    
    // MARK: - BindData
    private func bindData() {
        vm.inputViewDidLoadTrigger.value = ()
        
        vm.outputCityList.bind { [weak self] _ in
            guard let self else {return }
            self.viewManager.cityListTableView.reloadData()
        }
    }

    // MARK: - SetupDelegate
    private func setupDelegate() {
        viewManager.cityListTableView.dataSource = self
        viewManager.cityListTableView.delegate = self
        viewManager.cityListTableView.register(CityListTableViewCell.self, forCellReuseIdentifier: CityListTableViewCell.description())
        
    }
    // MARK: - AddTarget
    private func setupAddTarget() {
    }
    // MARK: - EventSelector
    // MARK: - SetupUI
    // MARK: - APIFetch
    // MARK: - PageTransition
}


extension CityListSearchViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let list = vm.outputCityList.value else {return 0}
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CityListTableViewCell.description(), for: indexPath) as! CityListTableViewCell
        guard let list = vm.outputCityList.value else {return cell}
        let data = list[indexPath.row]
        cell.configureData(data: data)
        return cell
    }
}

