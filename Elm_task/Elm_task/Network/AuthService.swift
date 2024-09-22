//
//  AuthService.swift
//  Elm_task
//
//  Created by Abdelrahman.Youssef on 21/09/2024.
//

import Foundation
import Combine

class AuthService {
    
    
    func login(email: String) -> AnyPublisher<String, NetworkError> {
        guard let url = URLBuilder.buildURL(for: APIConstants.Endpoints.login) else {
            return Fail(error: NetworkError.invalidURL)
                .eraseToAnyPublisher()
        }

        let loginRequest = LoginRequest(email: email)
        guard let body = try? JSONEncoder().encode(loginRequest) else {
            return Fail(error: NetworkError.invalidRequest)
                .eraseToAnyPublisher()
        }

        
        return NetworkService.shared.request(url: url, method: .post, body: body, requiresDecoding: false)
            .mapError { NetworkError.networkError($0) }
            .eraseToAnyPublisher()
    }
    
    func verifyOTP(email: String, otp: String) -> AnyPublisher<OTPResponse, NetworkError> {
            guard let url = URLBuilder.buildURL(for: APIConstants.Endpoints.otpVerify) else {
                return Fail(error: NetworkError.invalidURL)
                    .eraseToAnyPublisher()
            }

            let otpRequest = OTPRequest(email: email, otp: otp)
            guard let body = try? JSONEncoder().encode(otpRequest) else {
                return Fail(error: NetworkError.invalidRequest)
                    .eraseToAnyPublisher()
            }

            return NetworkService.shared.request(url: url, method: .post, body: body, requiresDecoding: true)
                .mapError { NetworkError.networkError($0) }
                .eraseToAnyPublisher()
        }
    
}
