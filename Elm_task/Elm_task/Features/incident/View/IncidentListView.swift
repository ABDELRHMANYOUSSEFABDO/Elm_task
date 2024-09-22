//
//  IncidentListView.swift
//  Elm_task
//
//  Created by Abdelrahman.Youssef on 22/09/2024.
//

import SwiftUI

struct IncidentListView: View {
    @ObservedObject var viewModel: IncidentListViewModel
    
    var body: some View {
        VStack {
            
            if viewModel.isLoading {
                VStack {
                    Spacer()
                    ProgressView("Loading incidents...")
                    Spacer()
                }
            }
            
            
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.red.opacity(0.7))
                    .cornerRadius(10)
                    .padding([.leading, .trailing, .top])
            }
            
            // Date Picker
            HStack {
                Text("Filter by Date")
                    .font(.headline)
                DatePicker("", selection: $viewModel.selectedDate, displayedComponents: [.date])
                    .datePickerStyle(CompactDatePickerStyle())
                    .onChange(of: viewModel.selectedDate) { _ in
                        viewModel.filterIncidents()
                    }
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(10)
            .padding(.horizontal)
            
            // Status Picker
            Picker("Status", selection: $viewModel.selectedStatus) {
                Text("All").tag(-1)
                Text("Submitted").tag(0)
                Text("In Progress").tag(1)
                Text("Completed").tag(2)
                Text("Rejected").tag(3)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)
            .onChange(of: viewModel.selectedStatus) { newValue in
                
                viewModel.filterIncidents()
            }
            
            
            if !viewModel.filteredIncidents.isEmpty {
                ScrollView {
                    LazyVStack(spacing: 10) {
                        ForEach(viewModel.filteredIncidents) { incident in
                            Button(action: {
                                // viewModel.goToIncidentDetails(incident: incident)
                            }) {
                                IncidentRow(incident: incident)
                                    .padding([.leading, .trailing])
                            }
                        }
                    }
                }
            } else {
                Text("No incidents found.")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding()
            }
        }
        .navigationTitle("Incidents")
        .toolbar {
            HStack {
                
                Button(action: {
                    viewModel.goNewIncidet()
                }) {
                    Image(systemName: "plus")
                }
                
                
                Button(action: {
                    viewModel.goDashboard()
                }) {
                    Image(systemName: "chart.bar")
                }
            }
        }
        
        
        .onAppear {
            viewModel.fetchIncidents()
        }
    }
}


struct IncidentListView_Previews: PreviewProvider {
    static var previews: some View {
        let mockIncidentService = MockIncidentService()
        let mockCoordinator = MockIncidentCoordinator()
        IncidentListView(viewModel: IncidentListViewModel(incidentService: mockIncidentService, coordinator: mockCoordinator))
    }
}
