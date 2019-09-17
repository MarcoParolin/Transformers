//
//  TransformerDetailViewController.swift
//  Transformers
//
//  Created by Marco Parolin on 14/09/2019.
//  Copyright © 2019 Marco Parolin. All rights reserved.
//

import UIKit
import ServiceManager

class TransformerDetailViewController: BaseViewController<TransformerDetailCoordinator, TransformerDetailViewModel> {
    
    @IBOutlet weak var teamSelector: TeamSelector?
    @IBOutlet weak var nameTextField: UITextField?
    @IBOutlet weak var rankSlider: AttributeSlider?
    @IBOutlet weak var strengthSlider: AttributeSlider?
    @IBOutlet weak var intelligenceSlider: AttributeSlider?
    @IBOutlet weak var speedSlider: AttributeSlider?
    @IBOutlet weak var enduranceSlider: AttributeSlider?
    @IBOutlet weak var courageSlider: AttributeSlider?
    @IBOutlet weak var firepowerSlider: AttributeSlider?
    @IBOutlet weak var skillSlider: AttributeSlider?
    
    override var rightNavigationButtons: [UIBarButtonItem] {
        switch viewModel.mode {
        case .add:
            return [UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveTransformer))]
        case .edit:
            return [UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editTransformer))]
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSliders()
        setupTextField()
        
        teamSelector?.setup(viewModel.transformer.team, self)
    }
    
    // MARK: Setup
    private func setupSliders() {
        rankSlider?.setup(viewModel.transformer.rank, viewModel.transformer.team, nil, self, "Rank")
        strengthSlider?.setup(viewModel.transformer.strength, viewModel.transformer.team, .strenght, self)
        intelligenceSlider?.setup(viewModel.transformer.intelligence, viewModel.transformer.team, .intelligence, self)
        speedSlider?.setup(viewModel.transformer.speed, viewModel.transformer.team, .speed, self)
        enduranceSlider?.setup(viewModel.transformer.endurance, viewModel.transformer.team, .endurance, self)
        courageSlider?.setup(viewModel.transformer.courage, viewModel.transformer.team, .courage, self)
        firepowerSlider?.setup(viewModel.transformer.firepower, viewModel.transformer.team, .firepower, self)
        skillSlider?.setup(viewModel.transformer.skill, viewModel.transformer.team, .skill, self)
    }
    
    private func setupTextField() {
        nameTextField?.text = viewModel.transformer.name
        nameTextField?.addTarget(self, action: #selector(nameDidChange), for: .editingChanged)
    }
    
    private func updateSliderTeams(_ team: Team) {
        rankSlider?.updateTeam(team)
        strengthSlider?.updateTeam(team)
        intelligenceSlider?.updateTeam(team)
        speedSlider?.updateTeam(team)
        enduranceSlider?.updateTeam(team)
        courageSlider?.updateTeam(team)
        firepowerSlider?.updateTeam(team)
        skillSlider?.updateTeam(team)
    }
    
    // MARK: Listeners
    @objc private func nameDidChange() {
        viewModel.transformer.name = nameTextField?.text
    }
    
    @objc private func saveTransformer() {
        viewModel.saveTransformer() 
    }
    
    @objc private func editTransformer() {
        viewModel.saveTransformer()
    }
}

// MARK: - AttributeSlierDelegate
extension TransformerDetailViewController: AttributeSlierDelegate {
    func didChangeValue(onSlider slider: AttributeSlider, withValue value: Int) {
        switch slider {
        case rankSlider:
            viewModel.transformer.rank = value
        case strengthSlider:
            viewModel.transformer.strength = value
        case intelligenceSlider:
            viewModel.transformer.intelligence = value
        case speedSlider:
            viewModel.transformer.speed = value
        case enduranceSlider:
            viewModel.transformer.endurance = value
        case courageSlider:
            viewModel.transformer.courage = value
        case firepowerSlider:
            viewModel.transformer.firepower = value
        case skillSlider:
            viewModel.transformer.skill = value
        default:
            break
        }
    }
}

// MARK: - TeamSelectorDelegate
extension TransformerDetailViewController: TeamSelectorDelegate {
    func didSelect(_ selector: TeamSelector, _ value: Team) {
        if selector == teamSelector {
            viewModel.transformer.team = value
            updateSliderTeams(value)
        }
    }
}
