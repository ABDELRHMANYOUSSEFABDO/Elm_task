//
//  IncidentTypeModel.swift
//  Elm_task
//
//  Created by Abdelrahman.Youssef on 22/09/2024.
//

import Foundation

struct IncidentTypesResponse: Codable {
    let types: [IncidentType]
}

struct IncidentType: Codable, Identifiable {
    let id: Int
    let arabicName: String
    let englishName: String
    let subTypes: [SubType]
}

struct SubType: Codable, Identifiable {
    let id: Int
    let arabicName: String
    let englishName: String
    let categoryId: Int
}
