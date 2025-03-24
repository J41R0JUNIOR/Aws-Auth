//
//  SignUp_View.swift
//  Clinic Project
//
//  Created by The Godfather Júnior on 17/01/25.
//

import SwiftUI

struct SignUp_View: View, ViewProtocol {
    
    @Bindable var viewModel: SignUp_ViewModel
    
    var body: some View {
        ZStack{
            
            VStack{
                HStack{
                    Text("Sign Up")
                        .font(.largeTitle)
                    Spacer()
                }
                
                Spacer()
                
                HStack{
                    Text("Email:")
                    Spacer()
                }
                
                TextField("Type your email", text: $viewModel.user.email)
                    .autocapitalization(.none)
                    .textContentType(.emailAddress)
                    .keyboardType(.emailAddress)
                
                HStack{
                    Text("Password:")
                    Spacer()
                }
                
                TextField("type your password", text: $viewModel.user.password)
                    .textContentType(.password)
                
                HStack{
                    Text("Confirm Password:")
                    Spacer()
                }
                
                TextField("confirm your password", text: $viewModel.user.confirmPassword)
                    .textContentType(.password)
                
                Spacer()
                
                HStack{
                    Button {
                        viewModel.backToSignIn()
                        
                    } label: {
                        HStack{
                            Spacer()
                            Text("Cancel")
                                .foregroundStyle(.red)
                            Spacer()
                        }
                    }
                    .buttonStyle(.bordered)
                    
                    Button {
                        viewModel.signUp()
                        
                    } label: {
                        HStack{
                            Spacer()
                            Text("Confirm")
                            Spacer()
                        }
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
            .textFieldStyle(.roundedBorder)
            .padding()
            
            if viewModel.showAlert {
                VStack {
                    CustomCodeAlert(signUpCode: $viewModel.signUpCode,
                                    showAlert: $viewModel.showAlert,
                                    sendCode: {viewModel.sendCode(confirmationCode: viewModel.signUpCode)},
                                    resendCode: {viewModel.resendCode()})

                }
            }
        }
    }
}

#Preview {
    SignUp_View(viewModel: .init())
}
