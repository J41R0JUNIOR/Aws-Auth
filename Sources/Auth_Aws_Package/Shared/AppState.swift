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
    
    public var state: State = .signOut
}

public enum State{
    case logged
    case signOut
}
