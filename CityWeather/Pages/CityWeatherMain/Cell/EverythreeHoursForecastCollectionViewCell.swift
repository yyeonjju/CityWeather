//
//  EverythreeHoursForecastCollectionViewCell.swift
//  CityWeather
//
//  Created by 하연주 on 7/11/24.
//

import UIKit
import SnapKit

final class EverythreeHoursForecastCollectionViewCell : UICollectionViewCell {
    
    // MARK: - UI
    private let contentsStackView = {
       let sv = UIStackView()
        sv.axis = .vertical
        sv.alignment = .center
        sv.distribution = .equalSpacing
        return sv
    }()
    
    private let timeLabel  = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.text = "-"
        return label
    }()
    
    private let weatherImageView  = {
        let iv = UIImageView()
        return iv
    }()
    
    private let temperatureLabel  = {
        let label = UILabel()
        label.text = "-"
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    
    // MARK: - Initializer
    
    override init(frame : CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
        configureSubView()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ConfigureData
    func configureData(data : Forecast){
        timeLabel.text = data.timeText
        weatherImageView.loadImage(urlString: data.iconImageURL)
        temperatureLabel.text = data.temparatureText
    }

    
    // MARK: - ConfigureUI
    
    private func configureSubView() {
        [contentsStackView]
            .forEach{
                contentView.addSubview($0)
            }
        
        [timeLabel, weatherImageView, temperatureLabel]
            .forEach{
                contentsStackView.addArrangedSubview($0)
            }
        
        
    }
    
    private func configureLayout() {
        contentsStackView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
        
        weatherImageView.snp.makeConstraints { make in
            make.size.equalTo(50)
        }
    }

    
    
}
