//
//  CityListTableViewCell.swift
//  CityWeather
//
//  Created by 하연주 on 7/13/24.
//

import UIKit
import SnapKit

final class CityListTableViewCell : UITableViewCell {
    // MARK: - UI
    let sharp = {
        let label = UILabel()
        label.text = "#"
        return label
    }()
    
    let citynameLabel = {
        let label = UILabel()
        label.text = "Seoul"
        return label
    }()
    
    let countryLabel = {
        let label = UILabel()
        label.text = "KR"
        label.font = .boldSystemFont(ofSize: 14)
        label.textColor = Assets.Color.gray5
        return label
    }()
    
    // MARK: - Initializer
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        backgroundColor = .clear
        configureSubView()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ConfigureData
    func configureData(data : CityInfo) {
        citynameLabel.text = data.name
        countryLabel.text = data.country
    }
    
    
    // MARK: - ConfigureUI
    
    private func configureSubView() {
        [sharp, citynameLabel, countryLabel]
            .forEach{
                contentView.addSubview($0)
            }
    }
    
    private func configureLayout() {
        sharp.snp.makeConstraints { make in
            make.leading.equalTo(contentView)
            make.top.equalTo(contentView).offset(8)
        }
        citynameLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(8)
            make.leading.equalTo(sharp.snp.trailing).offset(8)
            
        }
        countryLabel.snp.makeConstraints { make in
            make.top.equalTo(citynameLabel.snp.bottom).offset(4)
            make.leading.equalTo(citynameLabel)
            make.bottom.equalTo(contentView).inset(8)
        }
    }

}


