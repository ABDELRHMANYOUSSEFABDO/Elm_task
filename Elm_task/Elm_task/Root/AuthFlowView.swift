//
//  AuthFlowView.swift
//  Elm_task
//
//  Created by Abdelrahman.Youssef on 21/09/2024.
//

import SwiftUI
struct AuthFlowView: View {
    @EnvironmentObject var authCoordinator: AuthCoordinator
    @EnvironmentObject var appCoordinator: AppCoordinator
    
    
    var body: some View {
        switch authCoordinator.currentView {
        case .login:
            LoginView(viewModel: LoginViewModel(coordinator: authCoordinator))
        case .otp:
            if let email = authCoordinator.getEmail() {
                OTPView(viewModel: OTPViewModel(email: email, coordinator: appCoordinator))
            }
        }
    }
}
