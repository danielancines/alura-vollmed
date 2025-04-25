//
//  ScheduleAppointment.swift
//  Vollmed
//
//  Created by daniel.ancines on 25/04/25.
//

import Foundation

struct ScheduleAppointmentRequest: Codable {
    let specialist: String
    let patient: String
    let date: String
    
    enum CodingKeys: String, CodingKey {
        case specialist = "especialista"
        case patient = "paciente"
        case date = "data"
    }
}
