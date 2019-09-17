//
//  DeleteTransformerService.swift
//  ServiceManager
//
//  Created by Marco Parolin on 12/09/2019.
//  Copyright © 2019 Marco Parolin. All rights reserved.
//

import Foundation
import Alamofire

// MARK: - Endpoint
class DeleteTransformerService: BaseService {
    var path: String { return "transformers/:id" }
}

// MARK: - Request
class DeleteTransformerRequest: BaseAuthenticatedRequest {
    
    private let id: String
    
    var method: HTTPMethod { return .delete }
    var service: BaseService { return DeleteTransformerService() }
    
    var resultClass: ResponseObject.Type? {
        return DeleteTransformerResponseObject.self
    }
    
    var pathParams: [String: Any]? {
        return ["id": id]
    }
    
    init(id: String) {
        self.id = id
    }

}

// MARK: - Response
class DeleteTransformerResponseObject: ResponseObject {
    
    var transformers: [Transformer]?
    
    // MARK: Custom Encoders / Decoders
    
    private enum CodingKeys: String, CodingKey {
        case transformers
    }
    
    required init(from decoder: Decoder) throws {
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.transformers = try? container.decode([Transformer].self, forKey: .transformers)
            
        } catch let error {
            print("Error while decoding DeleteTransformerResponseObject: \(error)")
        }
        try super.init(from: decoder)
    }
    
    override public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        do {
            try container.encodeIfPresent(transformers, forKey: .transformers)
            try super.encode(to: encoder)
        } catch let error {
            print("Error while encoding DeleteTransformerResponseObject: \(error)")
        }
    }
    
    required init() {
        fatalError("init() has not been implemented")
    }
    
    required init(stringValue: String) {
        fatalError("init(stringValue:) has not been implemented")
    }
}
