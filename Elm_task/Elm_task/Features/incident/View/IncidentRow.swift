//
//  IncidentRow.swift
//  Elm_task
//
//  Created by Abdelrahman.Youssef on 22/09/2024.
//

import SwiftUI

import SwiftUI

struct IncidentRow: View {
    let incident: Incident

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Image(systemName: "exclamationmark.triangle.fill")
                    .foregroundColor(.red)
                    .font(.title)
                
                VStack(alignment: .leading) {
                    Text("Status: \(incident.description)")
                        .font(.headline)
                        .foregroundColor(.blue)
                }
                
            }

            Divider()

            HStack {
               
                HStack {
                    Image(systemName: "doc.text.fill")
                        .foregroundColor(.gray)
                    Text("Incident ID: \(incident.id)")
                }
                .font(.footnote)
                .foregroundColor(.secondary)

                Spacer()
                
                // Created At Date
                HStack {
                    Image(systemName: "calendar")
                        .foregroundColor(.gray)
                    Text(incident.createdAt, formatter: Incident.dateFormatter)
                }
                .font(.footnote)
                .foregroundColor(.secondary)
            }
        }
        .padding()
        .background(Color(UIColor.systemGray6)) // Light background for cards
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
