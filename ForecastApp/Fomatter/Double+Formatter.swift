//
//  Double+Formatter.swift
//  ForecastApp
//
//  Created by 전혜성 on 2022/01/30.
//

import Foundation

fileprivate let temperatureFormatter: MeasurementFormatter = {
   let f = MeasurementFormatter()
    f.locale = Locale(identifier: "ko.kr")
    f.numberFormatter.maximumFractionDigits = 1
    f.unitOptions = .temperatureWithoutUnit
    return f
}()

extension Double {
    var temperatureString: String {
        let temp = Measurement<UnitTemperature>(value: self, unit: .celsius)
        return temperatureFormatter.string(from: temp)
    }
}
