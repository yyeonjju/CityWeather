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
    var navWillPop : ((Coord)->Void)?
    // MARK: - Lifecycle
    override func loadView() {
        view = viewManager
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBackButtonItem()
        hideKeyboardWhenTappedAround()
        setupDelegate()
        bindData()
    }
    
    // MARK: - BindData
    private func bindData() {
        vm.inputViewDidLoadTrigger.value = ()
        
        vm.outputCityList.bind { [weak self] _ in
            guard let self else {return }
            self.viewManager.cityListTableView.reloadData()
            view.endEditing(true)
        }
    }

    // MARK: - SetupDelegate
    private func setupDelegate() {
        viewManager.cityListTableView.dataSource = self
        viewManager.cityListTableView.delegate = self
        viewManager.cityListTableView.register(CityListTableViewCell.self, forCellReuseIdentifier: CityListTableViewCell.description())
        
        viewManager.citySearchbar.delegate = self
        
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
        cell.selectionStyle = .none
        guard let list = vm.outputCityList.value else {return cell}
        let data = list[indexPath.row]
        cell.configureData(data: data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let list = vm.outputCityList.value else {return }
        let data = list[indexPath.row]
        navWillPop?(Coord(lon: data.coord.lon, lat: data.coord.lat))
        navigationController?.popViewController(animated: true)
    }
}

extension CityListSearchViewController : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //검색
        guard let keyword  = searchBar.text else {return }
        vm.inputSearchKeyword.value = keyword
    }
}

