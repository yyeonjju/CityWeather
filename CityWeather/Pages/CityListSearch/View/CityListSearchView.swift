//
//  CityListSearchView.swift
//  CityWeather
//
//  Created by 하연주 on 7/13/24.
//

import UIKit
import SnapKit

final class CityListSearchView : BaseView {
    // MARK: - UI
    private let titleLabel  = {
        let label = UILabel()
        label.text = "City"
        label.font = .boldSystemFont(ofSize: 40)
        return label
    }()
    
    let citySearchbar = {
        let sb = UISearchBar()
        sb.searchBarStyle = .minimal
        sb.placeholder = "도시를 검색하세요"
        sb.searchTextField.textColor = .white
        return sb
    }()
    
    let cityListTableView = {
        let tv = UITableView()
        tv.backgroundColor = .clear
        return tv
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
    
    override func configureSubView() {
        [titleLabel, citySearchbar, cityListTableView]
            .forEach{
                addSubview($0)
            }
    }
    
    override func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(safeAreaLayoutGuide)
        }
        
        citySearchbar.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(40)
            
        }
        
        cityListTableView.snp.makeConstraints { make in
            make.top.equalTo(citySearchbar.snp.bottom).offset(4)
            make.bottom.equalTo(self)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(20)
        }
    }
    
}
