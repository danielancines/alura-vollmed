//
//  WebService.swift
//  Vollmed
//
//  Created by Giovanna Moeller on 12/09/23.
//

import UIKit

struct Response<T>{
    let data: T?
    let hasError: Bool
    let message: String
    
    init(data: T?){
        self.data = data
        self.hasError = false
        self.message = "Sucess"
    }
    
    init(data: T?, hasError: Bool, message: String){
        self.data = data
        self.hasError = hasError
        self.message = message
    }
}

struct SpecialistsService {
    
    private let baseURL = "http://localhost:3000"
    private let imageCache = NSCache<NSString, UIImage>()
    
    func scheduleAppointment(specialistID: String, patientID: String, date: String) async throws -> Response<ScheduleAppointmentResponse>? {
        let endpoint = "\(baseURL)/consulta"
        
        guard let url = URL(string: endpoint) else {
            print("Error at URL")
            return Response<ScheduleAppointmentResponse>(data: nil, hasError: true, message: "Error at URL, contact administrator")
        }
        
        let appointment = ScheduleAppointmentRequest(specialist: specialistID, patient: patientID, date: date)
        
        let jsonData = try JSONEncoder().encode(appointment)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 201 {
            if let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                return Response(data: nil, hasError: true, message: jsonObject["message"] as? String ?? "Error has ocurred")
            }
        }
        
        let appointmentResponse = try JSONDecoder().decode(ScheduleAppointmentResponse.self, from: data)
        
        return Response(data: appointmentResponse)
    }
    
    func getAllSpecialists() async throws -> [Specialist]? {
        guard let endpoint = URL(string: "\(baseURL)/specialist") else {
            print("Erro na URL!")
            return nil
        }
        
        let (data, _) = try await URLSession.shared.data(from: endpoint)
        let specialists = try JSONDecoder().decode([Specialist].self, from: data)
        
        return specialists
    }
    
    func downloadImage(from imageURL: String) async throws -> UIImage? {
        if let cachedImage = imageCache.object(forKey: imageURL as NSString) {
            return cachedImage
        }
        
        guard let url = URL(string: imageURL) else {
            print("Error downloading image")
            return nil
        }
        
        let(data, _) = try await URLSession.shared.data(from: url)
        guard let image = UIImage(data:data) else {
            return nil
        }
        
        imageCache.setObject(image, forKey: imageURL as NSString)
        
        return image
    }
}
