//
//  APIConstants.swift
//  Elm_task
//
//  Created by Abdelrahman.Youssef on 21/09/2024.
//

import Foundation

struct APIConstants {
    static let baseURL = "https://ba4caf56-6e45-4662-bbfb-20878b8cd42e.mock.pstmn.io"
    
    struct Endpoints {
        static let login = "/login"
        static let otpVerify = "/verify-otp"
        static let incidents = "/incident"
        static let dashboard = "/dashboard"
        static let type = "/types"

    }
}

class URLBuilder {
    static func buildURL(for endpoint: String) -> URL? {
        var components = URLComponents(string: APIConstants.baseURL)
        components?.path = endpoint
        return components?.url
    }
}

