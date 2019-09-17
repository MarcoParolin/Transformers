//
//  BaseRequest.swift
//  ServiceManager
//
//  Created by Marco Parolin on 12/09/2019.
//  Copyright © 2019 Marco Parolin. All rights reserved.
//

import Foundation
import Alamofire
import Locksmith

// MARK: - Base Request
protocol BaseRequest: RequestProtocol { }

extension BaseRequest {
    var headers: [String: String]? { return nil }
}

// MARK: - Authenticated Request
protocol BaseAuthenticatedRequest: RequestProtocol { }

extension BaseAuthenticatedRequest {
    
    private var token: String {
        guard let token = Keychain.token else { fatalError("Missing Token") }
        return token
    }
    
    var headers: [String: String]? {
        return ["Authorization": "Bearer \(token)", "Content-Type": "application/json"]
    }
}
