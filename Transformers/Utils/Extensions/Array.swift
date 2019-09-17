//
//  Array.swift
//  Transformers
//
//  Created by Marco Parolin on 16/09/2019.
//  Copyright © 2019 Marco Parolin. All rights reserved.
//

import Foundation

extension Array where Element == String {
    public func contains(_ element: String?) -> Bool {
        guard let string = element else { return false }
        return self.contains(string)
    }
}
