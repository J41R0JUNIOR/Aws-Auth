//
//  SignUp_ViewModel.swift
//  Clinic Project
//
//  Created by The Godfather Júnior on 17/01/25.
//

import Foundation
import ViewProtocol_Package


@Observable
@MainActor
class SignUp_ViewModel: @preconcurrency ViewModelProtocol {
    
    var interactor: SignUp_Interactor?
    var router: Router?
        
    var user = Model.UserSignUp(password: .init(), email: .init(), confirmPassword: .init())
    var signUpCode: String = ""
    var showAlert: Bool = false
    
    required init() {}
    
     func backToSignIn() {
        router?.navigate(to: .signIn, .pop)
    }
    
    func signUp() async {
        await interactor?.signUp(user: user)
    }
    
    func sendCode(confirmationCode: String) async {
        let user = Model.User(clientId: ClientId.clientId.rawValue, username: user.email, code: confirmationCode)

        await interactor?.sendEmailVerification(user: user)
    }
    
    func resendCode() {
        
    }
}
