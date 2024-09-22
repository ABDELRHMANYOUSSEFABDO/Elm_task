//
//  DashboardView.swift
//  Elm_task
//
//  Created by Abdelrahman.Youssef on 22/09/2024.
//

import SwiftUI
import Charts
struct DashboardView: View {
    @ObservedObject var viewModel: DashboardViewModel
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationView {
            VStack {
                
                Chart {
                    ForEach(viewModel.dashboardIncidents) { incident in
                        BarMark(
                            x: .value("Status", incident.status),
                            y: .value("Count", incident._count.status)
                        )
                        .foregroundStyle(by: .value("Status", incident.status))
                        .cornerRadius(5)
                        .annotation(position: .top) {
                            Text("\(incident._count.status)")
                                .font(.caption)
                                .foregroundColor(.black)
                        }
                    }
                }
                .frame(height: 250)
                .padding()
                .chartXAxisLabel("Incident Status")
                .chartYAxisLabel("Count")
                
                Spacer()
            }
            .navigationTitle("Incident Dashboard")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        viewModel.back()
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.blue)
                    }
                }
            }
            .onAppear {
                viewModel.fetchDashboardData()
            }
        }
    }
}


struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        let mockIncidentService = MockIncidentService()
        let mockCoordinator = MockIncidentCoordinator()
        DashboardView(viewModel: DashboardViewModel(incidentService: mockIncidentService, coordinator: mockCoordinator))
    }
}
