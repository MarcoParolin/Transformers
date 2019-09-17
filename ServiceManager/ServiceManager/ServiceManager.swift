//
//  ServiceManager.swift
//  ServiceManager
//
//  Created by Marco Parolin on 12/09/2019.
//  Copyright © 2019 Marco Parolin. All rights reserved.
//

import Foundation

public struct ServiceManager {
    /// Service Manager instance
    public static let shared = ServiceManager()
    
    /// Login Services
    public let login = LoginEndpoints()
    /// Transformer Services
    public let trasformers = TransformersEndpoints()
    
}
