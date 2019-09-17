//
//  MatchResultLabel.swift
//  Transformers
//
//  Created by Marco Parolin on 17/09/2019.
//  Copyright © 2019 Marco Parolin. All rights reserved.
//

import UIKit

class MatchResultLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        update()
    }
    
    private func setup() {
        self.font = UIFont.systemFont(ofSize: 14)
        self.textAlignment = .center
        self.translatesAutoresizingMaskIntoConstraints = false
        let heightConstraint = NSLayoutConstraint(item: self, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 30)
        self.addConstraints([heightConstraint])
    }
    
    private func update() {}

}
