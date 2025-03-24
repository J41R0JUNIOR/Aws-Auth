//
//  SignUp_Presenter.swift
//  Clinic Project
//
//  Created by The Godfather Júnior on 17/01/25.
//

import Foundation

protocol SignUp_Presenter_Protocol {
    
}

class SignUp_Presenter: SignUp_Presenter_Protocol, PresenterProtocol {
    weak var viewModel: SignUp_ViewModel?
    
    required init(viewModel: SignUp_ViewModel) {
        self.viewModel = viewModel
    }
    
    func userSignUpSuccess() {
        viewModel?.showAlert = true
    }
    
    func userSignUpFailed(message: String) {
        print("message \(message)")
    }
    
    func userSignUpVerificationSuccess() {
        viewModel?.showAlert = false
    }
    
    func userSignUpVerificationFailed(message: String) {
        
    }
}
