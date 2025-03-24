//
//  SignInInterator.swift
//  Clinic Project
//
//  Created by The Godfather Júnior on 11/12/24.
//

import Foundation
import ViewProtocol_Package

protocol SignIn_Presenter_Protocol {
    func userSignInSuccess(user: Model.SignInReturn)
    func userSignInFailure(error: Error)
    func userSignInFailure()
    func noUserSaved()
} 

@MainActor
class SignIn_Presenter: @preconcurrency SignIn_Presenter_Protocol, @preconcurrency PresenterProtocol {
//    var viewModel: SignIn_ViewModel?
    
    weak var viewModel: SignIn_ViewModel?
    
    required init(viewModel: SignIn_ViewModel) {
        self.viewModel = viewModel
    }
    
    func userSignInSuccess(user: Model.SignInReturn) {
//        DispatchQueue.main.async {
        self.viewModel?.state = .logged
//        }
    }
    
    func userSignInFailure(error: Error) {
            self.viewModel?.apiMessage = "\(error)"
            self.viewModel?.isRefreshing = false
        
    }
    
    func userSignInFailure() {
            self.viewModel?.isRefreshing = false
        
    }
    
    func noUserSaved() {
            self.viewModel?.apiMessage = "no user saved!"
        
    }
}
