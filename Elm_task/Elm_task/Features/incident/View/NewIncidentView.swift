//
//  NewIncidentView.swift
//  Elm_task
//
//  Created by Abdelrahman.Youssef on 22/09/2024.
//


import SwiftUI
import CoreLocation

struct NewIncidentView: View {
    @State private var description: String = ""
    @State private var latitude: String = ""
    @State private var longitude: String = ""
    @State private var selectedStatus: Int = 0
    @State private var selectedTypeId: Int? = nil
    @State private var issuerId: String = UUID().uuidString
    @State private var priority: Int? = nil
    @ObservedObject var viewModel: NewIncidentViewModel
    @StateObject private var locationManager = LocationManager()
    
    var body: some View {
        VStack(alignment: .leading) {
            // Incident Description
            TextField("Incident Description", text: $description)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            // Latitude (Auto-filled by CoreLocation)
            TextField("Latitude", text: $latitude)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .disabled(true) // Make it read-only
            
            // Longitude (Auto-filled by CoreLocation)
            TextField("Longitude", text: $longitude)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .disabled(true) // Make it read-only
            
            // Status Picker
            Picker("Status", selection: $selectedStatus) {
                Text("Submitted").tag(0)
                Text("In Progress").tag(1)
                Text("Completed").tag(2)
                Text("Rejected").tag(3)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            // Type Picker (from API)
            Picker("Select Type", selection: $selectedTypeId) {
                Text("Select Type").tag(nil as Int?)
                ForEach(viewModel.incidentTypes, id: \.id) { type in
                    Text(type.englishName).tag(type.id as Int?)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .padding()
            
            
            Button(action: {
                guard let latitudeValue = Double(latitude), let longitudeValue = Double(longitude), let typeId = selectedTypeId else {
                   
                    return
                }
                
                viewModel.postIncident(
                    description: description,
                    latitude: latitudeValue,
                    longitude: longitudeValue,
                    status: selectedStatus,
                    typeId: typeId,
                    priority: priority,
                    issuerId: issuerId
                )
            }) {
                Text("Submit Incident")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .navigationBarItems(leading: Button(action: {
                viewModel.back()
                   }) {
                       Image(systemName: "chevron.left")
                           .foregroundColor(.blue)
                   })
            .padding()
            
            
            if let successMessage = viewModel.successMessage {
                Text(successMessage)
                    .foregroundColor(.green)
                    .padding()
            }
            
            Spacer()
        }
        .navigationTitle("Submit Incident")
        .padding()
        .onAppear {
            viewModel.fetchIncidentTypes()
            locationManager.requestLocation()
        }
        .onChange(of: locationManager.lastKnownLocation) { newLocation in
            if let newLocation = newLocation {
                latitude = String(newLocation.coordinate.latitude)
                longitude = String(newLocation.coordinate.longitude)
            }
        }
    }
}

struct NewIncidentView_Previews: PreviewProvider {
    static var previews: some View {
        let mockIncidentService = MockIncidentService()
        let mockCoordinator = MockIncidentCoordinator()
        NewIncidentView(viewModel: NewIncidentViewModel(incidentService: mockIncidentService, coordinator: mockCoordinator))
    }
}
