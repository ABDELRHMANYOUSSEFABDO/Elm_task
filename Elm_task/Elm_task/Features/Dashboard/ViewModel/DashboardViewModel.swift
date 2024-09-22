//
//  DashboardViewModel.swift
//  Elm_task
//
//  Created by Abdelrahman.Youssef on 22/09/2024.
//

import SwiftUI
import Combine

class DashboardViewModel: ObservableObject {
    @Published var dashboardIncidents: [DashboardIncident] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private let incidentService: IncidentService
    private let coordinator: IncidentCoordinator
    private var cancellables = Set<AnyCancellable>()
    
    init(incidentService: IncidentService, coordinator: IncidentCoordinator) {
        self.incidentService = incidentService
        self.coordinator = coordinator
    }
    
    // Fetch dashboard data from the service
    func fetchDashboardData() {
        guard let token = KeychainManager.getToken(forKey: "authToken") else {
            errorMessage = "No authentication token found"
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        incidentService.getDashboard(token: token)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                switch completion {
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] dashboardIncidents in
                self?.dashboardIncidents = dashboardIncidents
            })
            .store(in: &cancellables)
    }
    
    func back (){
        coordinator.goBack()
    }
    
    
}
