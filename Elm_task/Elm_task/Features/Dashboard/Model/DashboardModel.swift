//
//  DashboardModel.swift
//  Elm_task
//
//  Created by Abdelrahman.Youssef on 22/09/2024.
//

import Foundation
struct DashboardResponse: Codable {
    let incidents: [DashboardIncident]
}
struct DashboardIncident: Codable, Identifiable {
    let id = UUID() 
    let status: Int
    let _count: IncidentCount
}

struct IncidentCount: Codable {
    let status: Int
}

