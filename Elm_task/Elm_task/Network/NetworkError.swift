//
//  NetworkError.swift
//  Elm_task
//
//  Created by Abdelrahman.Youssef on 21/09/2024.
//

import Foundation

enum NetworkError: Error {
    case invalidResponse
    case statusError(Int)
    case decodingError
    case unknown
}
