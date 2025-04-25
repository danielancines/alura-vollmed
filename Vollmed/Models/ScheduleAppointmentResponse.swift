//
//  ScheduleAppointmentResponse.swift
//  Vollmed
//
//  Created by daniel.ancines on 25/04/25.
//

import Foundation

struct ScheduleAppointmentResponse : Codable, Identifiable {
    let id: String
    let specialist: String
    let patient: String
    let date: String
    let reasonToCancel: String?
    
    enum CodingKeys : String, CodingKey {
        case id
        case specialist = "especialista"
        case patient = "paciente"
        case date = "data"
        case reasonToCancel = "motivoCancelamento"
    }
}
