//
//  DateFormatManager.swift
//  CityWeather
//
//  Created by 하연주 on 7/12/24.
//

import Foundation

final class DateFormatManager {
    static let shared = DateFormatManager()
    private init() {}
    
    enum FormatString : String {
        case date = "yyyy-MM-dd"
        case time = "HH:mm:ss"
        case dateAndTime = "yyyy-MM-dd HH:mm:ss"
        case hour = "a h"
        case weekday = "E"
//        case yearDotMonth = "yyyy.MM"
//        case yearDotMonthDotDay = "yyyy.MM.dd"
    }
    
    enum FormatterType {
        case utcZoneTime
        case krLocaleTime
        
        var formatter : DateFormatter {
            get {
                switch self {
                case .utcZoneTime:
                    let formatter = DateFormatter()
                    formatter.timeZone = TimeZone(secondsFromGMT:0)
                    return formatter
                case .krLocaleTime:
                    let formatter = DateFormatter()
                    formatter.locale = .init(identifier: "ko_KR")
                    return formatter
                }
            }
        }
    }
    
    
    func getDateFormatter(formatterType : FormatterType = .krLocaleTime , format : FormatString) -> DateFormatter {
        let formatter = formatterType.formatter
        formatter.dateFormat = format.rawValue
        return formatter
    }
    
    func convertSpecificZoneStringToLocalZoneString(SpecificTimeZoneFormatter : DateFormatManager.FormatterType, SpecificZoneString : String, fromFormat : DateFormatManager.FormatString, toFormat : DateFormatManager.FormatString) -> String {
        let utcZoneDate = DateFormatManager.shared.getDateFormatter(formatterType : SpecificTimeZoneFormatter, format: fromFormat).date(from: SpecificZoneString)
        guard let utcZoneDate else {return "-"}
        let localDateString = DateFormatManager.shared.getDateFormatter(formatterType: .krLocaleTime , format: toFormat).string(from: utcZoneDate)
        
        return localDateString
    }
}
