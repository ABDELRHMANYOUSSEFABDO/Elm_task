//
//  IncidentCoordinator.swift
//  Elm_task
//
//  Created by Abdelrahman.Youssef on 22/09/2024.
//

import Foundation
class IncidentCoordinator: ObservableObject {
    @Published var currentView: IncidentView = .list
    
    func goBack() {
        currentView = .list
    }
    
    func navigateToIncidentDashboard() {
        currentView = .dashboard
    }
    
    func navigateToIncidentAdd() {
        currentView = .add
    }
    
}

enum IncidentView {
    case list
    case dashboard
    case add
    
}
