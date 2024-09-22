//
//  RootView.swift
//  Elm_task
//
//  Created by Abdelrahman.Youssef on 21/09/2024.
//

import SwiftUI
struct RootView: View {
    @EnvironmentObject var appCoordinator: AppCoordinator
    
    var body: some View {
        NavigationStack {
            switch appCoordinator.currentView {
            case .auth:
                AuthFlowView()
                    .environmentObject(appCoordinator.authCoordinator)
                
            case .splash:
                let splashViewModel = SplashViewModel(coordinator: appCoordinator)
                SplashView(viewModel: splashViewModel)
            case .incident:
                IncidentFlowView()
                    .environmentObject(appCoordinator.incidentCoordinator)
            }
        }
    }
}
