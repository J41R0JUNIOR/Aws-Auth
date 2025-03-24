//
//  SignUp_ViewModel.swift
//  Clinic Project
//
//  Created by The Godfather Júnior on 17/01/25.
//

import Foundation

@Observable
class SignUp_ViewModel: ViewModelProtocol {
    var interactor: SignUp_Interactor?
    var router: Routes?
        
    var user = Model.UserSignUp(password: .init(), email: .init(), confirmPassword: .init())
    var signUpCode: String = ""
    var showAlert: Bool = false
    
    required init() {}
    
    func backToSignIn() {
        router?.navigate(to: .signIn, .pop)
    }
    
    func signUp() {
        interactor?.signUp(user: user)
    }
    
    func sendCode(confirmationCode: String) {
        let user = Model.User(clientId: ClientId.clientId.rawValue, username: user.email, code: confirmationCode)

        interactor?.sendEmailVerification(user: user)
    }
    
    func resendCode() {
        
    }
}
