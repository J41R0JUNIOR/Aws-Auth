//
//  CustomAlert.swift
//  Clinic Project
//
//  Created by The Godfather Júnior on 20/01/25.
//

import SwiftUI

struct CustomCodeAlert: View {
    @Binding var signUpCode: String
    @Binding var showAlert: Bool
    var sendCode: () -> Void
    var resendCode: () -> Void
    
    var body: some View {
        ZStack{
            Rectangle()
                .opacity(0.95)
                .ignoresSafeArea()
                .foregroundStyle(.black)
            
            VStack{
                HStack{
                    Text("Code")
                        .font(.largeTitle)
                        .foregroundStyle(.white)
                    Spacer()
                }
                
                Spacer()
                HStack{
                    Text("Set the code:")
                        .foregroundStyle(.white)
                    Spacer()
                }
                
                TextField("--- ---", text: $signUpCode)
                    .keyboardType(.numberPad)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.white)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.white, lineWidth: 0.5)
                    )
                
                HStack{
                    Spacer()
                    
                    Button {
                        resendCode()
                        
                    } label: {
                        Text("send again")
                        
                    }
                }
                
                Spacer()
                
                Button {
                    sendCode()
                    
                } label: {
                    HStack{
                        Spacer()
                        Text("Send")
                        Spacer()
                    }
                }
                .buttonStyle(.borderedProminent)
            }.padding()
                
        }
    }
}

//#Preview {
//    CustomCodeAlert(signUpCode: .constant(""), showAlert: .constant(true), sendCode: {}, resendCode: {})
//}

#Preview {
    SignUp_View(viewModel: .init())
}
