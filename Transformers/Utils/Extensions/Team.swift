//
//  Team.swift
//  Transformers
//
//  Created by Marco Parolin on 14/09/2019.
//  Copyright © 2019 Marco Parolin. All rights reserved.
//

import UIKit
import ServiceManager
import Rswift

extension Team {
    var icon: UIImage {
        switch self {
        case .autobots:
            return R.image.autobotsIcon() ?? UIImage()
        case .decepticons:
            return R.image.decepticonsIcon() ?? UIImage()
        }
    }
    
    var color: UIColor {
        switch self {
        case .autobots:
            return Constants.autobotsColor
        case .decepticons:
            return Constants.decepticonsColor
        }
    }
}
