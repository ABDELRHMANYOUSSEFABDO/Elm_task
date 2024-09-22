//
//  MockIncidentService.swift
//  Elm_task
//
//  Created by Abdelrahman.Youssef on 22/09/2024.
//

import Foundation
import SwiftUI
import Combine
class MockIncidentService: IncidentService {
    override func getIncidents(token: String) -> AnyPublisher<[Incident], NetworkError> {
        
        let mockIncidents = [
            Incident(id: "1", description: "Test Incident", status: 1, priority: 1, createdAt: Date()),
            Incident(id: "2", description: "Another Incident", status: 2, priority: 1, createdAt: Date())
        ]
        return Just(mockIncidents)
            .setFailureType(to: NetworkError.self)
            .eraseToAnyPublisher()
    }
}

class MockIncidentCoordinator: IncidentCoordinator {}
