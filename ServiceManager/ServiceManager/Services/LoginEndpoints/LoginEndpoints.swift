//
//  LoginEndpoints.swift
//  ServiceManager
//
//  Created by Marco Parolin on 12/09/2019.
//  Copyright © 2019 Marco Parolin. All rights reserved.
//

import Foundation

public struct LoginEndpoints {
    /// Get the token that represent the "user" i'm currently logged on, so I can get my own pool of Transformers
    public func getToken(completion: @escaping () -> Void, failure: @escaping (Error) -> Void) {
        // If a token is already saved, I don't need to request a new one
        if Keychain.token != nil {
            completion()
            return
        }
        TokenRequest().sendRequest(success: { response in
            guard let token = response.stringValue else {
                failure(ServiceError.invalidResponse)
                return
            }
            Keychain.saveToken(token)
            completion()
        }, failure: failure)
    }
    
    /// Clear Token if I need a new set of Transformers
    public func clearToken() {
        Keychain.deleteToken()
    }
}
