//
//  UIImageView++.swift
//  CityWeather
//
//  Created by 하연주 on 7/12/24.
//

import UIKit


extension UIImageView {
    func loadImage(urlString: String) {
        ImageLoadManager.shared.downloadImage(urlString: urlString) { data in
            DispatchQueue.main.async() { [weak self] in
                guard let self, let image = UIImage(data: data) else {return}
                self.image = image
            }
        }
    }
    
}
