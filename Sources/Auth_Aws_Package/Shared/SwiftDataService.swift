//
//  SwiftDataService.swift
//  Clinic Project
//
//  Created by The Godfather Júnior on 15/12/24.
//

import Foundation
import SwiftData

@MainActor
class SwiftDataService {
    static var shared = SwiftDataService()
    var container: ModelContainer?
    var context: ModelContext?
    
    init() {
        do {
            container = try ModelContainer(for: Model.LoginUserSwiftData.self)
            if let container {
                context = ModelContext(container)
            }
        } catch {
            print("Error: \(error)")
        }
    }
    
    func save(login: Model.LoginUserSwiftData) {
        if let context = context {
            context.insert(login)
            do {
                try context.save()
            } catch {
                print("Error saving data: \(error)")
            }
        }
    }

    func fetch(onCompletition: @escaping (Result<[Model.LoginUserSwiftData], Error>) -> Void) {
        let descriptor = FetchDescriptor<Model.LoginUserSwiftData>() // Busca todos os objetos do tipo
        
        if let context = context {
            do {
                let data = try context.fetch(descriptor)
                onCompletition(.success(data))
            } catch {
                onCompletition(.failure(error))
            }
        } else {
            onCompletition(.failure(NSError(domain: "ContextError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Context is nil"])))
        }
    }

    func delete(login: Model.LoginUserSwiftData) {
        if let context = context {
            context.delete(login)
            do {
                try context.save()
            } catch {
                print("Error saving after delete: \(error)")
            }
        }
    }
    
    func deleteAll() {
        if let context = context {
            let descriptor = FetchDescriptor<Model.LoginUserSwiftData>()
            do {
                let data = try context.fetch(descriptor)
                data.forEach { context.delete($0) }
                
                try context.save()
            } catch {
                print("Error deleting all data: \(error)")
            }
        }
    }
}
