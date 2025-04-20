//
//  WebService.swift
//  Vollmed
//
//  Created by Giovanna Moeller on 12/09/23.
//

import UIKit

struct SpecialistsService {
    
    private let baseURL = "http://localhost:3000"
    private let imageCache = NSCache<NSString, UIImage>()
    
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
