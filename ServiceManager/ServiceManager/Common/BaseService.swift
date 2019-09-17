//
//  BaseService.swift
//  ServiceManager
//
//  Created by Marco Parolin on 12/09/2019.
//  Copyright © 2019 Marco Parolin. All rights reserved.
//

import Foundation
import Alamofire

protocol BaseService {
    var path: String { get }
    var baseUrl: URL { get }
    var session: SessionManager { get }
}

extension BaseService {
    
    var baseUrl: URL {
        guard let url = URL(string: Constants.baseURLString) else { fatalError("Invalid URL") }
        return url
    }
    
    var session: SessionManager { return SessionManager.default }
}
