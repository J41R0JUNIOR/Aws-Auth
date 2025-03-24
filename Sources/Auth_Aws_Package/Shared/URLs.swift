//
//  URLs.swift
//  Crud-AWS
//
//  Created by The Godfather Júnior on 10/12/24.
//

import Foundation

public enum BaseUrl: String {
    case aws = "https://oortbbeqid.execute-api.us-east-1.amazonaws.com/dev/"
}

public enum URLs {
    case authSignUp
    case authSignIn
    case confirmSignUp

    
    var url: String {
        
        switch self {
        case .authSignUp:
            return "\(BaseUrl.aws.rawValue)signUp"
            
        case .authSignIn:
            return "\(BaseUrl.aws.rawValue)signIn"
            
        case .confirmSignUp:
            return "\(BaseUrl.aws.rawValue)confirmSighUp"
        }
    }
}

public enum ClientId: String {
    case clientId = "69ei4lganceag4esfpf26e58g3"
}

public enum MethodApi: String {
    case get = "GET"
    case post = "POST"
    case patch = "PATCH"
    case delete = "DELETE"
}
