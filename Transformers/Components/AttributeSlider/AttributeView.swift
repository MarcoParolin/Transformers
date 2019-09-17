//
//  AttributeView.swift
//  Transformers
//
//  Created by Marco Parolin on 16/09/2019.
//  Copyright © 2019 Marco Parolin. All rights reserved.
//

import UIKit
import ServiceManager

class AttributeView: UIView {
     
    private var barLayer = CAShapeLayer()
    private var team: Team?
    private var attributeValue: Int = 0 { didSet { update() } }
    
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
        self.layer.addSublayer(barLayer)
        self.layer.borderWidth = 1
        self.layer.masksToBounds = false
    }
    
    private func update() {
        barLayer.frame = self.bounds
        let wdt = ((self.bounds.width/9) * CGFloat(attributeValue - 1))
        barLayer.path = CGPath(rect: CGRect(x: 0, y: 0, width: wdt, height: self.bounds.height), transform: nil)
    }
    
    func setTeam(_ team: Team?) {
        guard let team = team else {
            barLayer.fillColor = UIColor.gray.cgColor
            self.layer.borderColor = UIColor.gray.cgColor
            return
        }
        
        switch team {
        case .autobots:
            barLayer.fillColor = Constants.autobotsColor.cgColor
            self.layer.borderColor = Constants.autobotsColor.cgColor
        case .decepticons:
            barLayer.fillColor = Constants.decepticonsColor.cgColor
            self.layer.borderColor = Constants.decepticonsColor.cgColor
        }
    }
    
    func setValue(_ value: Int) {
        self.attributeValue = value
    }
}
