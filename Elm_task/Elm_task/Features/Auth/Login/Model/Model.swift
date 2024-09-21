//
//  Model.swift
//  Elm_task
//
//  Created by Abdelrahman.Youssef on 21/09/2024.
//

import Foundation

struct LoginRequest: Codable {
    let email: String
}

struct LoginResponse: Codable {
    let message: String?
}
