//
//  NetworkService.swift
//  Elm_task
//
//  Created by Abdelrahman.Youssef on 21/09/2024.
//

import Foundation
import Combine

class NetworkService {
    static let shared = NetworkService()
    private init() {}
    
    func request<T: Decodable>(url: URL, method: HTTPMethod = .get, body: Data? = nil) -> AnyPublisher<T, NetworkError> {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        if let body = body {
            request.httpBody = body
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { (data, response) in
                guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                    throw NetworkError.statusError((response as? HTTPURLResponse)?.statusCode ?? 500)
                }
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { _ in NetworkError.decodingError }
            .eraseToAnyPublisher()
    }
}
