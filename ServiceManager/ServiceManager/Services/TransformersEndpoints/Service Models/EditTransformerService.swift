//
//  EditTransformerService.swift
//  ServiceManager
//
//  Created by Marco Parolin on 12/09/2019.
//  Copyright © 2019 Marco Parolin. All rights reserved.
//

import Foundation
import Alamofire

// MARK: - Endpoint
class EditTransformerService: BaseService {
    var path: String { return "transformers" }
}

// MARK: - Request
class EditTransformerRequest: BaseAuthenticatedRequest {
    
    private let transformer: Transformer
    
    var method: HTTPMethod { return .put }
    var service: BaseService { return EditTransformerService() }
    var resultClass: ResponseObject.Type? {
        return EditTransformerResponseObject.self
    }
    
    var bodyParams: Encodable? {
        return transformer
    }
    
    init(transformer: Transformer) {
        self.transformer = transformer
    }

}

// MARK: - Response
class EditTransformerResponseObject: Transformer { }
