//
//  IncidentListViewModel.swift
//  Elm_task
//
//  Created by Abdelrahman.Youssef on 22/09/2024.
//

import Combine
import SwiftUI

class IncidentListViewModel: ObservableObject {
    @Published var incidents: [Incident] = []
    @Published var filteredIncidents: [Incident] = []
    @Published var selectedStatus: Int = -1 // Default to "All"
    @Published var selectedDate: Date = Date()
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private var cancellables = Set<AnyCancellable>()
    private let incidentService: IncidentService
    private let coordinator: IncidentCoordinator

    init(incidentService: IncidentService, coordinator: IncidentCoordinator) {
        self.incidentService = incidentService
        self.coordinator = coordinator
    }

    // Fetch incidents from the server
    func fetchIncidents() {
        guard let token = KeychainManager.getToken(forKey: "authToken") else {
                    errorMessage = "No authentication token found"
                    return
                }
        isLoading = true
        errorMessage = nil
        
        incidentService.getIncidents(token: token)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                switch completion {
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] incidents in
                self?.incidents = incidents
                self?.filteredIncidents = incidents
            })
            .store(in: &cancellables)
    }

    // Filter incidents based on the selected status and date
    func filterIncidents() {
        filteredIncidents = incidents.filter { incident in
            let statusMatches = selectedStatus == -1 || incident.status == selectedStatus
            let dateMatches = Calendar.current.isDate(incident.createdAt, inSameDayAs: selectedDate)
            return statusMatches && dateMatches
        }
    }

    func goDashboard(){
        coordinator.navigateToIncidentDashboard()
        
    }
    func goNewIncidet(){
        coordinator.navigateToIncidentAdd()
        
    }
    
}
