//
//  AddIncidentModel.swift
//  Elm_task
//
//  Created by Abdelrahman.Youssef on 22/09/2024.
//

import Foundation

struct AddIncident: Codable {
    let description: String
    let latitude: Double
    let longitude: Double
    let status: Int
    let typeId: Int
    let priority: Int?
    let issuerId: String
}
