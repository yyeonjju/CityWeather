//
//  UILabel.swift
//  CityWeather
//
//  Created by 하연주 on 7/12/24.
//

import UIKit

extension UILabel {
    
    //UILabel에 아이콘 넣기
    func attachIcon(image : UIImage, direction:IconDirection, tintColor : UIColor = .black ,size : CGRect = CGRect(x: 0, y: 0, width: 20, height: 20), text : String, font: UIFont){
        //NSAttributedString 형태로 이미지 만들기
        let attachment = NSTextAttachment()
        attachment.image = image.withTintColor(tintColor)
        attachment.bounds = size
        let attachmentStr = NSAttributedString(attachment: attachment)
        
        //NSMutableAttributedString 형태를 만들어
        let mutableAttributedString = NSMutableAttributedString()
        
        if direction == .leading {
            //.leading이면 이미지 append 먼저
            mutableAttributedString.append(attachmentStr)
        }

        //텍스트 append
        let textString = NSAttributedString(string: text, attributes: [.font: font])
        mutableAttributedString.append(textString)
        
        if direction == .trailing {
            //.trailing이면 이미지 append 나중에
            mutableAttributedString.append(attachmentStr)
        }
        
        self.attributedText = mutableAttributedString
    }
    
}
