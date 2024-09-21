//
//  OTPViewModel.swift
//  Elm_task
//
//  Created by Abdelrahman.Youssef on 21/09/2024.
//

import Foundation
import Combine

class OTPViewModel: ObservableObject {
    @Published var email: String
//    @Published var otp: String = ""
    @Published var isLoading: Bool = false
    @Published var otpSuccess: Bool = false
    @Published var errorMessage: String?

    private var cancellables = Set<AnyCancellable>()
    private let authService: AuthService
    private let coordinator: AuthCoordinator

    init(email: String,authService: AuthService = AuthService(), coordinator: AuthCoordinator) {
        self.authService = authService
        self.coordinator = coordinator
        self.email = email
    }

    
    func verifyOTP(otp:String) {
        guard !otp.isEmpty else {
            errorMessage = "OTP is required"
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        authService.verifyOTP(email: email, otp: otp)
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
                // Handle successful OTP verification
                self.otpSuccess = true
            }
            .store(in: &self.cancellables)
    }
}
