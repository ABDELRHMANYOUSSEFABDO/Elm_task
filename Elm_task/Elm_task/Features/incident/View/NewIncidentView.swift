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
            
            TextField("Incident Description", text: $description)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .onTapGesture {
                    self.dismissKeyboard()
                }
            
            TextField("Latitude", text: $latitude)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .disabled(true) // Read-only field
                .onTapGesture {
                    self.dismissKeyboard()
                }
           
            TextField("Longitude", text: $longitude)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .disabled(true) // Read-only field
                .onTapGesture {
                    self.dismissKeyboard()
                }
            
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
                self.dismissKeyboard() // Dismiss keyboard when button is pressed
                
                guard let latitudeValue = Double(latitude), let longitudeValue = Double(longitude), let typeId = selectedTypeId else {
                    // Handle invalid input, return if validation fails
                    return
                }
                
                // Call the postIncident function from the view model
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
            .padding()
            
            // Success Message
            if let successMessage = viewModel.successMessage {
                Text(successMessage)
                    .foregroundColor(.green)
                    .padding()
            }
            
            Spacer()
        }
        .navigationBarItems(leading: Button(action: {
            viewModel.back() // Back button action
        }) {
            Image(systemName: "chevron.left")
                .foregroundColor(.blue)
        })
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
    
    // Helper function to dismiss the keyboard
    private func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}


struct NewIncidentView_Previews: PreviewProvider {
    static var previews: some View {
        let mockIncidentService = MockIncidentService()
        let mockCoordinator = MockIncidentCoordinator()
        NewIncidentView(viewModel: NewIncidentViewModel(incidentService: mockIncidentService, coordinator: mockCoordinator))
    }
}
