//
//  MarkUp.swift
//  Clinic Project
//
//  Created by The Godfather Júnior on 17/01/25.
//

import SwiftUI

struct CheckBox_Component: View {
    @Binding var condition: Bool
    var text: String
    var body: some View {
        HStack{
            Button {
                condition.toggle()
            } label: {
                HStack {
                    Image(systemName: condition ? "checkmark.square.fill" : "square")
                        .foregroundColor(condition ? .blue : .gray)
                        .font(.system(size: 15))
                }
            }
            
            Text(text)
                .foregroundColor(.primary)
                .font(.subheadline)
            
            Spacer()
        }
    }
}

#Preview {
    CheckBox_Component(condition: .constant(true), text: "Remember Me")
}
