//
//  Elm_taskApp.swift
//  Elm_task
//
//  Created by Abdelrahman.Youssef on 21/09/2024.
//

import SwiftUI

@main
struct Elm_taskApp: App {
    @StateObject var appCoordinator = AppCoordinator()

        var body: some Scene {
            WindowGroup {
                switch appCoordinator.currentView {
                case .splash:
                    // Pass the coordinator when initializing the SplashViewModel
                    let splashViewModel = SplashViewModel(coordinator: appCoordinator)
                    SplashView(viewModel: splashViewModel)

                case .login:
                    // Add your LoginView or a placeholder here
                    Text("Login Screen")
                }
            }
        }
    }
