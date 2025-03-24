//
//  SignIn.swift
//  Clinic Project
//
//  Created by The Godfather Júnior on 11/12/24.
//

import SwiftUI

struct SignIn_View: View, ViewProtocol {
    
    @Bindable var viewModel: SignIn_ViewModel
    
    var body: some View {
        ZStack{
            VStack{
                HStack{
                    Text("Sign In")
                        .font(.largeTitle)
                    Spacer()
                }
                
                Spacer()
                
                HStack{
                    Text("Email:")
                    Spacer()
                }
                
                TextField("Type your email", text: $viewModel.username)
                    .textContentType(.emailAddress)
                    .keyboardType(.emailAddress)
                
                HStack{
                    Text("Password:")
                    Spacer()
                }
                
                SecureField("type your password", text: $viewModel.password)
                    .textContentType(.password)
                
                Warning_Component(message: $viewModel.apiMessage)
                
                CheckBox_Component(condition: $viewModel.rememberMe, text: "Remember me")
                
                Spacer()
                
                Button {
                    viewModel.signIn()
                } label: {
                    HStack{
                        Spacer()
                        Text("Sign In")
                        Spacer()
                    }
                }
                .buttonStyle(.borderedProminent)
                
                HStack{
                    Text("Don't have an account?")
                    Button {
                        viewModel.signUp()
                    } label: {
                        Text("Sign Up")
                            .bold()
                    }
                }
            }
            .textFieldStyle(.roundedBorder)
            .autocapitalization(.none)
            .padding()
            
            .task{
                viewModel.tryAutoSignIn()
            }
            .onChange(of: viewModel.state, { _, _ in
                viewModel.handleStateChange()
            })
            
            if viewModel.isRefreshing {
                Rectangle()
                    .opacity(0.7)
                    .ignoresSafeArea()
                    .foregroundStyle(.black)
                
                ProgressView("Loading...")
                    .tint(.white)
                    .foregroundStyle(.white)
            }
        }
    }
}

#Preview {
    SignIn_View(viewModel: .init())
}
