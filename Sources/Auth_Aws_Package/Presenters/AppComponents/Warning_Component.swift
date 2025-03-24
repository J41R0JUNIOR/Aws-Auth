//
//  Warning_Component.swift
//  Clinic Project
//
//  Created by The Godfather Júnior on 17/01/25.
//

import SwiftUI

struct Warning_Component: View {
    @Binding var message: String
    
    var body: some View {
        HStack{
            if message != "" {
                Text("*\(message)").foregroundColor(.red)
            }
            Spacer()
        }
    }
}

#Preview {
    Warning_Component(message: .constant("No Warning"))
}
