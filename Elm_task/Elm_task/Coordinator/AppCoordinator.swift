//
//  AppCoordinator.swift
//  Elm_task
//
//  Created by Abdelrahman.Youssef on 21/09/2024.
//

import Foundation
import SwiftUI

enum AppView {
    case splash
    case login
}

class AppCoordinator: ObservableObject {
    @Published var currentView: AppView = .splash
    
    func navigateToLogin() {
            currentView = .login
        }
    
    }

