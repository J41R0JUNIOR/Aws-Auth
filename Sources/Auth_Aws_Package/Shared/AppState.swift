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
    public static var shared = AppState()
    
    public var state: States = .signOut
}

public enum States{
    case logged
    case signOut
}
