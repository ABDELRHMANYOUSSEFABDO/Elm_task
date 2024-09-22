import Combine
import Foundation

class NetworkService {
    static let shared = NetworkService()
    private init() {}

    func request<T: Decodable>(url: URL, method: HTTPMethod = .get, body: Data? = nil, requiresDecoding: Bool = true, token: String? = nil) -> AnyPublisher<T, NetworkError> {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        // Set token if available
        if let token = token {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        if let body = body {
            request.httpBody = body
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }

        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { (data, response) -> T in
                guard let httpResponse = response as? HTTPURLResponse,
                      (200..<300).contains(httpResponse.statusCode) else {
                    throw NetworkError.statusError((response as? HTTPURLResponse)?.statusCode ?? 500)
                }

                if !requiresDecoding {
                    if let stringResponse = String(data: data, encoding: .utf8), stringResponse == "OK" {
                        return stringResponse as! T
                    } else {
                        throw NetworkError.invalidResponse
                    }
                }
                
                // For other APIs that need JSON decoding
                return try JSONDecoder().decode(T.self, from: data)
            }
            .mapError { NetworkError.networkError($0) }
            .eraseToAnyPublisher()
    }
}
