//
//  AddIncidentListViewModel.swift
//  Elm_task
//
//  Created by Abdelrahman.Youssef on 22/09/2024.
//

import Foundation
import Combine
import SwiftUI

class NewIncidentViewModel: ObservableObject {
    @Published var successMessage: String?
    
    private var cancellables = Set<AnyCancellable>()
    private let incidentService: IncidentService
    private let coordinator: IncidentCoordinator
    @Published var incidentTypes: [IncidentType] = []
    
    init(incidentService: IncidentService, coordinator: IncidentCoordinator) {
        self.incidentService = incidentService
        self.coordinator = coordinator
        
    }
    
    func fetchIncidentTypes() {
        guard let token = KeychainManager.getToken(forKey: "authToken") else {
            return
        }
        incidentService.getIncidentTypes(token: token)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("Error fetching types: \(error.localizedDescription)")
                }
            }, receiveValue: { [weak self] types in
                self?.incidentTypes = types
            })
            .store(in: &cancellables)
    }
    
    func postIncident(description: String, latitude: Double, longitude: Double, status: Int, typeId: Int, priority: Int?, issuerId: String) {
        guard let token = KeychainManager.getToken(forKey: "authToken") else {
            return
        }
        
        let newIncident = AddIncident(description: description, latitude: latitude, longitude: longitude, status: status, typeId: typeId, priority: priority, issuerId: issuerId)
        incidentService.postIncident(token: token, incident: newIncident)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print(error.localizedDescription)
                }
            }, receiveValue: { [weak self] _ in
                self?.successMessage = "Incident submitted successfully!"
            })
            .store(in: &cancellables)
    }
    
    func back(){
        coordinator.goBack()
    }
}
