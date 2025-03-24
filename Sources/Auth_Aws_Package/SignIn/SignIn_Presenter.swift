//
//  SignInInterator.swift
//  Clinic Project
//
//  Created by The Godfather Júnior on 11/12/24.
//

import Foundation

protocol SignIn_Presenter_Protocol {
    func userSignInSuccess(user: Model.SignInReturn)
    func userSignInFailure(error: Error)
    func userSignInFailure()
    func noUserSaved()
} 

class SignIn_Presenter: SignIn_Presenter_Protocol, PresenterProtocol {
//    var viewModel: SignIn_ViewModel?
    
    weak var viewModel: SignIn_ViewModel?
    
    required init(viewModel: SignIn_ViewModel) {
        self.viewModel = viewModel
    }
    
    func userSignInSuccess(user: Model.SignInReturn) {
        DispatchQueue.main.async {
            self.viewModel?.state = .logged
        }
    }
    
    func userSignInFailure(error: Error) {
        DispatchQueue.main.async {
            self.viewModel?.apiMessage = "\(error)"
            self.viewModel?.isRefreshing = false
        }
    }
    
    func userSignInFailure() {
        DispatchQueue.main.async {
            self.viewModel?.isRefreshing = false
        }
    }
    
    func noUserSaved() {
        DispatchQueue.main.async {
            self.viewModel?.apiMessage = "Nenhum usuário salvo!"
        }
    }
}
