//
//  ApiError.swift
//  ForecastApp
//
//  Created by 전혜성 on 2022/01/30.
//

import Foundation

enum ApiError: Error {
    case unKnown
    case invalidUrl(String)
    case invalidResponse
    case failed(Int)
    case emptyData
}
