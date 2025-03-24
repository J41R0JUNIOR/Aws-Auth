//
//  AppState.swift
//  Clinic Project
//
//  Created by The Godfather Júnior on 16/01/25.
//

import Foundation

@Observable
@MainActor
public class AppState{
    static var shared = AppState()
    
    var state: State = .signOut
}

enum State{
    case logged
    case signOut
}
