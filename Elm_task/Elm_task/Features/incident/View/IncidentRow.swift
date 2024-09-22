//
//  IncidentRow.swift
//  Elm_task
//
//  Created by Abdelrahman.Youssef on 22/09/2024.
//

import SwiftUI

struct IncidentRow: View {
    let incident: Incident

       var body: some View {
           VStack(alignment: .leading, spacing: 10) {
               Text("Incident ID: \(incident.id)")
                   .font(.headline)
                   .foregroundColor(.blue)
               
               Text("Description: \(incident.description)")
                   .font(.subheadline)
               
               HStack {
                   Text("Status: \(incident.status)")
                       .font(.footnote)
                       .foregroundColor(.gray)
                   Spacer()
                   Text("Created At: \(incident.createdAt, formatter: Incident.dateFormatter)")
                       .font(.footnote)
                       .foregroundColor(.gray)
               }
           }
           .padding()
           .background(Color.white)
           .cornerRadius(10)
           .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
       }
   }

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .short
    return formatter
}()


#Preview {
    IncidentRow(incident: Incident.sample())
}
