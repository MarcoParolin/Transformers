//
//  AttributeSlider.swift
//  Transformers
//
//  Created by Marco Parolin on 16/09/2019.
//  Copyright © 2019 Marco Parolin. All rights reserved.
//

import UIKit
import ServiceManager

protocol AttributeSlierDelegate: class {
    func didChangeValue(onSlider slider: AttributeSlider, withValue value: Int)
}

class AttributeSlider: BaseComponent {
    
    @IBOutlet weak var valueLabel: UILabel?
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var slider: UISlider?
    @IBOutlet weak var attributeView: AttributeView?
    
    weak var delegate: AttributeSlierDelegate?

    // MARK: Computed properties
    private var attribute: Expertise? {
        didSet {
            handleAttribute(attribute)
        }
    }
    
    private var customText: String? = nil {
        didSet {
            handleAttribute(nil)
        }
    }
    private var sliderValue: Int = 0 {
        didSet {
            self.attributeView?.setValue(sliderValue)
            self.valueLabel?.text = "\(sliderValue)"
        }
    }
    
    // MARK: Setup
    func setup(_ value: Int?, _ team: Team?, _ attribute: Expertise?, _ delegate: AttributeSlierDelegate, _ customText: String? = nil) {
        super.setup()
        self.sliderValue = value ?? 0
        self.slider?.value = Float(value ?? 0)
        self.attributeView?.setTeam(team)
        self.attributeView?.setValue(value ?? 0)
        self.attribute = attribute
        self.titleLabel?.textColor = team?.color
        self.valueLabel?.textColor = team?.color
        self.delegate = delegate
        self.customText = customText
        self.attribute = attribute
    }
    
    func updateTeam(_ team: Team?) {
        self.attributeView?.setTeam(team)
        self.titleLabel?.textColor = team?.color
        self.valueLabel?.textColor = team?.color
    }
    
    /// Set Text based on a given expertise
    /// - Parameter attribute: Expertise
    private func handleAttribute(_ attribute: Expertise?) {
        guard let attribute = attribute else {
            self.titleLabel?.text = customText?.uppercased()
            return
        }
        switch attribute {
        case .strenght:
            self.titleLabel?.text = "strenght".uppercased()
        case .intelligence:
            self.titleLabel?.text = "intelligence".uppercased()
        case .speed:
            self.titleLabel?.text = "speed".uppercased()
        case .endurance:
            self.titleLabel?.text = "endurance".uppercased()
        case .courage:
            self.titleLabel?.text = "courage".uppercased()
        case .firepower:
            self.titleLabel?.text = "firepower".uppercased()
        case .skill:
            self.titleLabel?.text = "skill".uppercased()
        }
    }
    
    // MARK: Actions
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        self.slider?.value = Float(Int(sender.value))
        self.sliderValue = Int(sender.value)
        delegate?.didChangeValue(onSlider: self, withValue: Int(sender.value))
    }
}
