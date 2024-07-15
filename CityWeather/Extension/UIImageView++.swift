//
//  UIImageView++.swift
//  CityWeather
//
//  Created by 하연주 on 7/12/24.
//

import UIKit


extension UIImageView {
    func loadImage(urlString: String) {
        ImageCacheManager.shared.loadImage(urlString: urlString) {[weak self] image in
            guard let self, let image else {return }
            self.image = image
        }
    }
    
    
    func configureCircleImageView() {
        self.backgroundColor = .gray
        self.layer.cornerRadius = self.frame.width/2
        self.contentMode = .scaleAspectFill
    }
    
}
