//
//  incidentModel.swift
//  Elm_task
//
//  Created by Abdelrahman.Youssef on 22/09/2024.
//

import Foundation

struct IncidentResponse: Codable {
    let incidents: [Incident]
}

struct Incident: Identifiable, Codable {
    let id: String
    let description: String
    let status: Int
    let priority: Int?
    let createdAt: Date
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case description
        case status
        case priority
        case createdAt
    }
    
    
    init(id: String, description: String, status: Int, priority: Int?, createdAt: Date) {
        self.id = id
        self.description = description
        self.status = status
        self.priority = priority
        self.createdAt = createdAt
    }
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(String.self, forKey: .id)
        description = try container.decode(String.self, forKey: .description)
        status = try container.decode(Int.self, forKey: .status)
        priority = try container.decodeIfPresent(Int.self, forKey: .priority)
        
        
        let createdAtString = try container.decode(String.self, forKey: .createdAt)
        if let date = Incident.dateFormatter.date(from: createdAtString) {
            createdAt = date
        } else {
            throw DecodingError.dataCorruptedError(forKey: .createdAt,
                                                   in: container,
                                                   debugDescription: "Date string does not match format expected by formatter.")
        }
    }
    
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(description, forKey: .description)
        try container.encode(status, forKey: .status)
        try container.encode(priority, forKey: .priority)
        
        let dateString = Incident.dateFormatter.string(from: createdAt)
        try container.encode(dateString, forKey: .createdAt)
    }
    
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return formatter
    }()
}

extension Incident {
    static func sample() -> Incident {
        
        return Incident(
            id: "sample-id",
            description: "Sample incident description",
            status: 1,
            priority: 2,
            createdAt: Date()
        )
    }
}
