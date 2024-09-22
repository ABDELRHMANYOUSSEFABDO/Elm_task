//
//  IncidentService.swift
//  Elm_task
//
//  Created by Abdelrahman.Youssef on 22/09/2024.
//

import Foundation
import Combine

class IncidentService {
    
    
    func getIncidents(token: String) -> AnyPublisher<[Incident], NetworkError> {
        guard let url = URLBuilder.buildURL(for: APIConstants.Endpoints.incidents) else {
            return Fail(error: NetworkError.invalidURL)
                .eraseToAnyPublisher()
        }
        
        
        return NetworkService.shared.request(url: url, method: .get, body: nil, requiresDecoding: true, token: token)
            .tryMap { (incidentResponse: IncidentResponse) in
                return incidentResponse.incidents
            }
            .mapError { NetworkError.networkError($0) }
            .eraseToAnyPublisher()
    }
    
    func getDashboard(token: String) -> AnyPublisher<[DashboardIncident], NetworkError> {
        guard let dashboardURL = URLBuilder.buildURL(for: APIConstants.Endpoints.dashboard) else {
            return Fail(error: NetworkError.invalidURL)
                .eraseToAnyPublisher()
        }
        
        
        return NetworkService.shared.request(url: dashboardURL, method: .get, body: nil, requiresDecoding: true, token: token)
            .tryMap { (dashboardResponse: DashboardResponse) in
                return dashboardResponse.incidents
                
            }
            .mapError { NetworkError.networkError($0) }
            .eraseToAnyPublisher()
    }
    
    
    
    func postIncident(token: String, incident: AddIncident) -> AnyPublisher<IncidentResponse, NetworkError> {
        // Step 1: Build the URL for the post incident endpoint
        guard let submitIncidentURL = URLBuilder.buildURL(for: APIConstants.Endpoints.incidents) else {
            return Fail(error: NetworkError.invalidURL)
                .eraseToAnyPublisher()
        }
        
        
        let jsonData: Data
        do {
            jsonData = try JSONEncoder().encode(incident)
        } catch {
            return Fail(error: NetworkError.invalidRequest)
                .eraseToAnyPublisher()
        }
        
        
        return NetworkService.shared.request(
            url: submitIncidentURL,
            method: .post,
            body: jsonData,
            requiresDecoding: true,
            token: token
        )
        .tryMap { (incidentResponse: IncidentResponse) in
            return incidentResponse
        }
        .mapError { NetworkError.networkError($0) }
        .eraseToAnyPublisher()
    }
    
    
    func getIncidentTypes(token: String) -> AnyPublisher<[IncidentType], NetworkError> {
        guard let url = URLBuilder.buildURL(for: APIConstants.Endpoints.type) else {
            return Fail(error: NetworkError.invalidURL)
                .eraseToAnyPublisher()
        }

        return NetworkService.shared.request(url: url, method: .get, body: nil, requiresDecoding: true, token: token)
            .tryMap { (incidentTypesResponse: [IncidentType]) in
                return incidentTypesResponse // Parse the response and return the incident types
            }
            .mapError { NetworkError.networkError($0) }
            .eraseToAnyPublisher()
    }

    
    
}
