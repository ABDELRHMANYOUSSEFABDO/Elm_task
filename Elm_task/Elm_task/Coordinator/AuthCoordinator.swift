//
//  AuthCoordinator.swift
//  Elm_task
//
//  Created by Abdelrahman.Youssef on 21/09/2024.
//

import Foundation
class AuthCoordinator: ObservableObject {
    @Published var currentView: AuthView = .login
    private var email: String?

    func navigateToOTP(with email: String) {
        self.email = email
        currentView = .otp
    }

    func navigateToLogin() {
        currentView = .login
    }

    func getEmail() -> String? {
        return email
    }
}

enum AuthView {
    case login
    case otp
}
