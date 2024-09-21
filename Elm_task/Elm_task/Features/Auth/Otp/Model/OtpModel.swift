//
//  OtpModel.swift
//  Elm_task
//
//  Created by Abdelrahman.Youssef on 21/09/2024.
//

import Foundation

struct OTPRequest: Codable {
    let email: String
    let otp: String
}

struct OTPResponse: Codable {
    let token: String
    let roles: [Int]
}
