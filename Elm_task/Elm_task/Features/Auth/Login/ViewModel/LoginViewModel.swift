//
//  LoginViewModel.swift
//  Elm_task
//
//  Created by Abdelrahman.Youssef on 21/09/2024.
//

import Combine
import Foundation

class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var isLoading: Bool = false
    @Published var loginSuccess: Bool = false
    @Published var errorMessage: String?

    private var cancellables = Set<AnyCancellable>()
    private let authService: AuthService
    private let coordinator: AuthCoordinator

    init(authService: AuthService = AuthService(), coordinator: AuthCoordinator) {
        self.authService = authService
        self.coordinator = coordinator 
    }

    func login() {
        guard !email.isEmpty else {
            errorMessage = "Email is required"
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        authService.login(email: email)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                self.isLoading = false
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                case .finished:
                    break
                }
            } receiveValue: { response in
                if response == "OK" {
                    self.loginSuccess = true
                    self.coordinator.navigateToOTP(with: self.email)
                } else {
                    self.errorMessage = "Invalid response"
                }
            }
            .store(in: &self.cancellables)
    }
}
