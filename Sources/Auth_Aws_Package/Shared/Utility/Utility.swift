//
//  File.swift
//  Clinic Project
//
//  Created by The Godfather Júnior on 11/12/24.
//

import Foundation

@MainActor
class Utility{
    
    static let shared = Utility()
    private init() {}
    
    func encode<T:Codable>(content: T) -> Data? {
        do {
            let data = try JSONEncoder().encode(content)
            return data
            
        } catch {
            return nil
        }
    }
    
    func decode<T: Decodable>(content: Data) throws -> T {
        let decoder = JSONDecoder()
        do {
            return try decoder.decode(T.self, from: content)
        } catch {
            print("Decoding error: \(error)")
            throw error
        }
    }

    
    func messageReceived(data: Data) -> String{
        if let responseString = String(data: data, encoding: .utf8) {
            var transformedResponse = responseString
            
            transformedResponse.removeAll { char in
                char == "\"" || char == "\\"
            }
            
            return .init(transformedResponse)
        }
        return ""
    }
}
