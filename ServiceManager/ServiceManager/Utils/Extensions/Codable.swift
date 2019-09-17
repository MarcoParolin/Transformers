//
//  Codable.swift
//  ServiceManager
//
//  Created by Marco Parolin on 12/09/2019.
//  Copyright © 2019 Marco Parolin. All rights reserved.
//

import Foundation

extension Encodable {
    /// Wrapper to encode a JSON Encodable
    func toJSONData() -> Data? {
        do {
            let json = try JSONEncoder().encode(self)
            return json
        } catch {
            print(error)
            return nil
        }
    }
}
