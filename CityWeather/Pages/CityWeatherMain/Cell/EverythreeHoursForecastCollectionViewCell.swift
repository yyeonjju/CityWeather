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
    let contentsStackView = {
       let sv = UIStackView()
        sv.axis = .vertical
        sv.alignment = .center
        sv.distribution = .equalSpacing
        return sv
    }()
    
    let timeLabel  = {
        let label = UILabel()
        label.text = "12시"
        return label
    }()
    
    let weatherImageView  = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "heart")
        return iv
    }()
    
    let temperatureLabel  = {
        let label = UILabel()
        label.text = "7"
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
    
    
    // MARK: - ConfigureUI
    
    func configureSubView() {
        [contentsStackView]
            .forEach{
                contentView.addSubview($0)
            }
        
        [timeLabel, weatherImageView, temperatureLabel]
            .forEach{
                contentsStackView.addArrangedSubview($0)
            }
        
        
    }
    
    func configureLayout() {
        contentsStackView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
        
//        timeLabel.snp.makeConstraints { make in
//            make.top.horizontalEdges.equalTo(contentView)
//            
//        }
    }

    
    
}
