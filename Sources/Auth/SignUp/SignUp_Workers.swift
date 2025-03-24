//
//  SignUp_Workers.swift
//  Clinic Project
//
//  Created by The Godfather Júnior on 17/01/25.
//

import Foundation

protocol SighUp_Worker_Protocol {
    
}

struct SighUp_Worker: SighUp_Worker_Protocol {
    func signUp(user: Model.User, completion: @escaping (Result<Void, Error>) -> Void){
        Task {
            do {
                try await signUp(user: user)
                completion(.success(Void()))
                
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func signUp(user: Model.User) async throws {
      
        let urlString = URLs.authSignUp.url
        
        guard let url = URL(string: urlString) else {
            throw Errors.invalidURL
        }
        
        let encodedUser = Utility.shared.encode(content: user)
        
        var request = URLRequest(url: url)
        request.httpMethod = MethodApi.post.rawValue
        request.httpBody = encodedUser
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (_, response) = try await URLSession.shared.data(for: request)
        
        if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode){
            throw Errors.invalidResponse
        }
    }
    
    func signUpConfirmation(user: Model.User, completion: @escaping (Result<Void, Error>) -> Void){
        Task {
            do {
                try await signUpConfirmation(user: user)
                completion(.success(Void()))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func signUpConfirmation(user: Model.User) async throws {
        let urlString = URLs.confirmSignUp.url
        
        guard let url = URL(string: urlString) else {
            throw Errors.invalidURL
        }
        
        let user = Utility.shared.encode(content: user)
        
        var request = URLRequest(url: url)
        request.httpMethod = MethodApi.post.rawValue
        request.httpBody = user
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (_ , response) = try await URLSession.shared.data(for: request)
                
        if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode){
            throw Errors.invalidResponse
        }
    }
}
