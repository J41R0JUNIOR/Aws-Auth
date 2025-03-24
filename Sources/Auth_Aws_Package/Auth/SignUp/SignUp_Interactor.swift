//
//  SignUp_Interactor.swift
//  Clinic Project
//
//  Created by The Godfather Júnior on 17/01/25.
//

import Foundation

protocol SignUp_Interactor_Protocol {
    
}
 
class SignUp_Interactor: SignUp_Interactor_Protocol, InteractorProtocol {
    private var authWorker: SighUp_Worker = .init()
    var presenter: SignUp_Presenter
    
    required init(presenter: SignUp_Presenter) {
        self.presenter = presenter
    }
    
    func signUp(user: Model.UserSignUp) {
//        if !self.validateUser(user: user){
//            self.presenter.userSignUpFailed(message: "Invalid, certificate all fields")
//            return
//        }
        
        //call worker to sign in passing the values and handling the errors or success
//        let contentUser = Model.User(username: user.email, password: user.password)
        let contentUser = Model.User(clientId: ClientId.clientId.rawValue, username: user.email, password: user.password, email: user.email)
       
        
        authWorker.signUp(user: contentUser, completion: { result in
            switch result{
            case .success(_):
                self.presenter.userSignUpSuccess()
                
            case .failure(let error):
                self.presenter.userSignUpFailed(message: error.localizedDescription)
                print("erro \(error)")
                
            }
        })
    }
    
    func validateUser(user: Model.UserSignUp) -> Bool {
        return !user.email.isEmpty &&
               !user.password.isEmpty &&
               !user.confirmPassword.isEmpty &&
                user.password == user.confirmPassword
    }
    
    func sendEmailVerification(user: Model.User) {
   
        authWorker.signUpConfirmation(user: user, completion: { result in
            switch result{
            case .success:
                self.presenter.userSignUpVerificationSuccess()
                
            case .failure(let error):
                self.presenter.userSignUpVerificationFailed(message: error.localizedDescription)
            }
        })
    }
}
