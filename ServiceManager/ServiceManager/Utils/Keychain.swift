//
//  Keychain.swift
//  ServiceManager
//
//  Created by Marco Parolin on 12/09/2019.
//  Copyright © 2019 Marco Parolin. All rights reserved.
//

import Foundation
import Locksmith

struct Keychain {
    
    /// The current token saved in Keychain
    static var token: String? {
        return Locksmith.loadDataForUserAccount(userAccount: Constants.mainAccount)?[Constants.tokenKey] as? String
    }
    
    /// Securely save a token to keychain
    /// - Parameter token: Token that needs to be saved
    static func saveToken(_ token: String) {
        do {
            try Locksmith.updateData(data: [Constants.tokenKey: token], forUserAccount: Constants.mainAccount)
        } catch {
            print("Failed to save token")
        }
    }
    
    /// Delete the token, if i need a new one
    static func deleteToken() {
        do {
            try Locksmith.deleteDataForUserAccount(userAccount: Constants.mainAccount)
        } catch {
            print("Failed to delete token")
        }
    }
}
