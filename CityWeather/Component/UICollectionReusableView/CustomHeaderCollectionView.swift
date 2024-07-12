//
//  CustomHeaderCollectionView.swift
//  CityWeather
//
//  Created by 하연주 on 7/12/24.
//

import UIKit
import SnapKit

/*

class CustomHeaderCollectionView: UICollectionReusableView {
    // MARK: - UI
    let iconImageView  = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "heart")
        return iv
    }()
    
    let titleLabel = {
        let label = UILabel()
        label.text = "sldkjf"
        return label
    }()
    
    // MARK: - Initializer
    
    override init(frame : CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .red
        configureSubView()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - ConfigureUI
    
    func configureSubView() {
        [iconImageView, titleLabel]
            .forEach{
                addSubview($0)
            }
    }
    
    func configureLayout() {
        iconImageView.snp.makeConstraints { make in
            make.size.equalTo(20)
            make.leading.equalTo(self.snp.leading).offset(10)
            make.centerY.equalTo(self.snp.centerY)
        }
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconImageView.snp.trailing)
            make.centerY.equalTo(self.snp.centerY)
        }
    }

}


*/
