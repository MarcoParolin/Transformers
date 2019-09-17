//
//  ExpertiseLabel.swift
//  Transformers
//
//  Created by Marco Parolin on 15/09/2019.
//  Copyright © 2019 Marco Parolin. All rights reserved.
//

import UIKit
import ServiceManager

class ExpertiseLabel: UILabel {

    var team: Team?
    var expertise: Expertise?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    init(team: Team?, expertise: Expertise?) {
        super.init(frame: .zero)
        self.team = team
        self.expertise = expertise
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        update()
    }
    
    private func setup() {
        if let team = team {
            switch team {
            case .autobots:
                self.backgroundColor = Constants.autobotsColor.withAlphaComponent(0.6)
            case .decepticons:
                self.backgroundColor = Constants.decepticonsColor.withAlphaComponent(0.6)
            }
        }
        self.text = expertise?.rawValue.uppercased()
        
        self.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        self.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        self.textAlignment = .center
        self.textColor = .white
        self.font = UIFont.systemFont(ofSize: 8, weight: .bold)
    }
    
    private func update() {
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
    }
    
}
