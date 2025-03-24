//
//  SignIn_ViewModel.swift
//  Clinic Project
//
//  Created by The Godfather Júnior on 11/12/24.
//

import Foundation
import SwiftData
import ViewProtocol_Package

@Observable
@MainActor
class SignIn_ViewModel: @preconcurrency ViewModelProtocol {
   
    var username: String = ""
    var password: String = ""
    var apiMessage: String = ""
    var rememberMe: Bool = false
    var state: State = AppState.shared.state
    var isRefreshing: Bool = false
    
    var interactor: SignIn_Interactor?
    var router: Router?
    var container: ModelContainer?
    var context: ModelContext?
    
    required init() {
        do {
            container = try ModelContainer(for: Model.LoginUserSwiftData.self)
            if let container {
                context = ModelContext(container)
            }
        } catch {
            print("Error initializing ModelContainer: \(error)")
        }
    }
    
     func signIn() async {
        isRefreshing = true
        await interactor?.signIn(username: username, password: password, rememberMe: rememberMe)
    }
    
     func signUp() {
        router?.navigate(to: .signUp)
    }
    
     func tryAutoSignIn() async{
        isRefreshing = true
        await interactor?.tryAutoSignIn()
    }
    
//    func handleStateChange() {
////        if state == .logged {
////            router?.navigate(to: .setting)
////        }
//    }
}
