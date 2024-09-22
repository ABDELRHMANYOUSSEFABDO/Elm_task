//
//  IncidentFlowView.swift
//  Elm_task
//
//  Created by Abdelrahman.Youssef on 22/09/2024.
//

import SwiftUI

struct IncidentFlowView: View {
    @EnvironmentObject var incidentCoordinator: IncidentCoordinator

    var body: some View {
        switch incidentCoordinator.currentView {
        case .list:
            IncidentListView(viewModel: IncidentListViewModel(incidentService: IncidentService(), coordinator: incidentCoordinator))
        
        case .dashboard:
            DashboardView(viewModel: DashboardViewModel(incidentService: IncidentService(), coordinator: incidentCoordinator))
        case .add:
            NewIncidentView(viewModel: NewIncidentViewModel(incidentService: IncidentService(), coordinator: incidentCoordinator))
        }
    }
}
