//
//  File.swift
//  Clinic Project
//
//  Created by The Godfather Júnior on 11/12/24.
//

import Foundation
import ViewProtocol_Package

protocol SignIn_Interactor_Protocol {

}

@MainActor
class SignIn_Interactor: SignIn_Interactor_Protocol, @preconcurrency InteractorProtocol {
    
    private var authWorker: SignIn_Worker = .init()
    var presenter: SignIn_Presenter
    
    required init(presenter: SignIn_Presenter) {
        self.presenter = presenter
    }
    
    func haveEmailAndPassword(username: String, password: String) -> Bool{
        if username.isEmpty || username.contains("@gmail.com") == false{
            let noUsersError = NSError(
                domain: "CheckEmail",
                code: 404,
                userInfo: [NSLocalizedDescriptionKey: "Missing email"]
            )
            self.presenter.userSignInFailure(error: noUsersError)
            
            return false
        }
        
        if  password.isEmpty {
            let noUsersError = NSError(
                domain: "CheckPassword",
                code: 404,
                userInfo: [NSLocalizedDescriptionKey: "Missing password"]
            )
            self.presenter.userSignInFailure(error: noUsersError)
            
            return false
        }
        
        return true
    }
    
    func signIn(username: String, password: String, rememberMe: Bool = false) async  {
        
        if !haveEmailAndPassword(username: username, password: password) {
            return
        }
        
        await authWorker.signIn(username: username, password: password) { result in
            switch result {
            case .success(let user):
                
//                AccessTokens.shared.user?.accessToken = user.accessToken
                
                self.presenter.userSignInSuccess(user: user)
                
                if rememberMe{
                    Task {
                         SwiftDataService.shared.deleteAll()
                         SwiftDataService.shared.save(login: Model.LoginUserSwiftData(username: username, password: password))
                    }
                }
                
            case .failure(let error):
                print(error)
//                let noUsersError = NSError(
//                    domain: "Sign",
//                    code: 404,
//                    userInfo: [NSLocalizedDescriptionKey: "Email or Password incorrect"]
//                )
//                self.presenter.userSignInFailure(error: noUsersError)
                self.presenter.userSignInFailure(error: error)
            }
        }
    }
    
    @MainActor func tryAutoSignIn() async {
        SwiftDataService.shared.fetch { result in
            switch result {
            case .success(let users):
                if let firstUser = users.first {
                    Task {
                        await self.signIn(username: firstUser.username, password: firstUser.password)
                    }
                    return
                }
                
                self.presenter.userSignInFailure()
            case .failure(let error):
                print("Error looking for users: \(error)")
                
                self.presenter.userSignInFailure(error: error)
            }
        }
    }
}
