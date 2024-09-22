//
//  AppCoordinator.swift
//  Elm_task
//
//  Created by Abdelrahman.Youssef on 21/09/2024.
//

import Foundation
import SwiftUI


class AppCoordinator: ObservableObject {
    @Published var currentView: AppFlow = .splash
    @Published var authCoordinator = AuthCoordinator()
    @Published var incidentCoordinator = IncidentCoordinator()
    
    func navigateToAuthFlow() {
        currentView = .auth
    }
    
}

enum AppFlow {
    case splash
    case auth
    case incident
}


