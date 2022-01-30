//
//  Date+Formatter.swift
//  ForecastApp
//
//  Created by 전혜성 on 2022/01/30.
//

import Foundation

fileprivate let dateFormatter: DateFormatter = {
    let f = DateFormatter()
    f.locale = Locale(identifier: "Ko_kr")
    return f
}()

extension Date {
    var dateString: String {
        dateFormatter.dateFormat = "M월 d일"
        return dateFormatter.string(from: self)
    }
    
    var timeString: String {
        dateFormatter.dateFormat = "HH:00"
        return dateFormatter.string(from: self)
    }
}

