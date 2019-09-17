//
//  BaseComponent.swift
//  Transformers
//
//  Created by Marco Parolin on 14/09/2019.
//  Copyright © 2019 Marco Parolin. All rights reserved.
//

import UIKit

class BaseComponent: UIView {
    @objc var nibView = UIView()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }
    
    func classNameForNib() -> String {
        return String(describing: self.classForCoder)
    }
    
    func loadNib() {
        let className = classNameForNib()
        
        if Bundle.main.path(forResource: className, ofType: "nib") != nil, let views = Bundle.main.loadNibNamed(className, owner: self, options: nil), let nibView = views.first as? UIView {
            self.nibView = nibView
            nibView.frame = self.bounds
            nibView.translatesAutoresizingMaskIntoConstraints = false
            addSubview(nibView)
            
            self.backgroundColor = UIColor.clear
            
            self.addConstraints([
                NSLayoutConstraint(item: nibView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1.0, constant: 0),
                NSLayoutConstraint(item: nibView, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1.0, constant: 0),
                NSLayoutConstraint(item: nibView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0),
                NSLayoutConstraint(item: nibView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0)
            ])
        }
        
        setup()
    }
    
    func setup() {}
    
}
