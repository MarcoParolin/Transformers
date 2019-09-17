//
//  ServiceError.swift
//  ServiceManager
//
//  Created by Marco Parolin on 12/09/2019.
//  Copyright © 2019 Marco Parolin. All rights reserved.
//

import Foundation

enum ServiceError: Error {
    case invalidURL
    case invalidRequest
    case invalidResponse
    case paramNotFound
}
