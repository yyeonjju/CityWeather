//
//  FiveDaysForecastTableViewCell.swift
//  CityWeather
//
//  Created by 하연주 on 7/11/24.
//

import UIKit
import SnapKit

struct DayMaxMinData{
    let dateString : String
    let maxTemp : Double
    let minTemp : Double
    let iconID : String
}

final class FiveDaysForecastTableViewCell : UITableViewCell {
    // MARK: - UI
    let contentsStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.alignment = .center
        sv.distribution = .equalSpacing
        return sv
    }()
    
    let weekdayLabel  = {
        let label = UILabel ()
        label.font = .systemFont(ofSize: 20)
        label.text = "오늘"
        return label
    }()
    
    let minTempLabel  = {
        let label = UILabel ()
        label.font = .systemFont(ofSize: 20)
        label.text = "-"
        label.textColor = Assets.Color.gray4
        return label
    }()
    
    let maxTempLabel  = {
        let label = UILabel ()
        label.font = .systemFont(ofSize: 20)
        label.text = "-"
        return label
    }()
    
    let weatherImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "star")
        return iv
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
    func configureData(data : DayMaxMinData) {
        let utcZoneDate = DateFormatManager.shared.getDateFormatter(formatterType : .utcZoneTime, format: .date).date(from: data.dateString)
        guard let utcZoneDate else {return }
        let krDateString = DateFormatManager.shared.getDateFormatter(formatterType: .krLocaleTime , format: .weekday).string(from: utcZoneDate)
        weekdayLabel.text = krDateString
        maxTempLabel.text = "최고 : \(Int(data.maxTemp))°"
        minTempLabel.text = "최저 : \(Int(data.minTemp))°"
        weatherImageView.loadImage(urlString: "\(APIURL.iconImageURL)\(data.iconID)\(APIURL.iconImageURLSuffix)")
    }

    
    // MARK: - ConfigureUI
    
    private func configureSubView() {
        [contentsStackView, weatherImageView]
            .forEach{
                contentView.addSubview($0)
            }
        
        [weekdayLabel, minTempLabel, maxTempLabel]
            .forEach{
                contentsStackView.addArrangedSubview($0)
            }
        
    }
    
    private func configureLayout() {
        contentsStackView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
        
        weatherImageView.snp.makeConstraints { make in
            make.trailing.equalTo(minTempLabel.snp.leading).offset(-10)
            make.centerY.equalTo(minTempLabel)
            make.size.equalTo(30)
        }
        
        
    }

}
