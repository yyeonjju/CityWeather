//
//  UtilFinc.swift
//  CityWeather
//
//  Created by 하연주 on 7/11/24.
//

import UIKit

func isOnlyWhitespace(_ text: String?) -> Bool {
    guard let text else {return true}
    return text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
}


func configureCollectionVewLayout (scrollDirection :  UICollectionView.ScrollDirection = .vertical, numberofItemInrow : Int, cellIneterSpacing : CGFloat = 10, sectionSpacing :  CGFloat = 30, height: CGFloat? = nil) -> UICollectionViewLayout{
    let layout = UICollectionViewFlowLayout()
    let numberofItemInrow : CGFloat = CGFloat(numberofItemInrow)
    
    let cellIneterSpacing : CGFloat = cellIneterSpacing
    let sectionSpacing : CGFloat = sectionSpacing
    let inset = UIEdgeInsets(top: sectionSpacing, left: sectionSpacing, bottom: sectionSpacing, right: sectionSpacing)
    let availableWidth = UIScreen.main.bounds.width - (cellIneterSpacing*numberofItemInrow) - inset.left - inset.right
    
    
    layout.itemSize = CGSize(width: availableWidth/numberofItemInrow, height: height ?? availableWidth/numberofItemInrow)
    layout.scrollDirection = scrollDirection
    layout.minimumLineSpacing = 10
    layout.minimumInteritemSpacing = cellIneterSpacing
    layout.sectionInset = inset
    
    return layout
}

/*
 func attachIcon(image : UIImage, direction:IconDirection, text : String) -> String{
 //NSAttributedString 형태로 이미지 만들기
 let attachment = NSTextAttachment()
 attachment.image = image
 attachment.image = attachment.image?.withTintColor(.white)
 attachment.bounds = CGRect(x: 0, y: 0, width: 20, height: 20)
 let attachmentStr = NSAttributedString(attachment: attachment)
 
 //NSMutableAttributedString 형태를 만들어
 let mutableAttributedString = NSMutableAttributedString()
 
 if direction == .leading {
 //.leading이면 이미지 append 먼저
 mutableAttributedString.append(attachmentStr)
 }
 
 //텍스트 append
 let textString = NSAttributedString(string: text)
 mutableAttributedString.append(textString)
 
 if direction == .trailing {
 //.trailing이면 이미지 append 나중에
 mutableAttributedString.append(attachmentStr)
 }
 
 return mutableAttributedString.string
 }
 */
