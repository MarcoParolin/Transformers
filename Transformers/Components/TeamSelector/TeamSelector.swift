//
//  TeamSelector.swift
//  Transformers
//
//  Created by Marco Parolin on 16/09/2019.
//  Copyright © 2019 Marco Parolin. All rights reserved.
//

import UIKit
import ServiceManager

protocol TeamSelectorDelegate: class {
    func didSelect(_ selector: TeamSelector, _ value: Team)
}

class TeamSelector: BaseComponent {
    
    @IBOutlet weak var autobotsButton: UIButton?
    @IBOutlet weak var decepticonsButton: UIButton?
    
    private var team: Team? {
        didSet {
            updateSelectedTeam()
        }
    }
    weak var delegate: TeamSelectorDelegate?
    
    // MARK: Setup
    func setup( _ team: Team?, _ delegate: TeamSelectorDelegate) {
        super.setup()
        self.team = team
        self.delegate = delegate
        
        autobotsButton?.setImage(R.image.autobotsIcon(), for: .normal)
        autobotsButton?.tintColor = Constants.autobotsColor
        decepticonsButton?.setImage(R.image.decepticonsIcon(), for: .normal)
        decepticonsButton?.tintColor = Constants.decepticonsColor
        
        updateSelectedTeam()
    }
    
    private func updateSelectedTeam() {
        guard let team = self.team else {
            autobotsButton?.alpha = 0.5
            decepticonsButton?.alpha = 0.5
            return
        }
        
        switch team {
        case .autobots:
            autobotsButton?.alpha = 1
            decepticonsButton?.alpha = 0.5
        case .decepticons:
            autobotsButton?.alpha = 0.5
            decepticonsButton?.alpha = 1
        }
    }
    
    // MARK: Actions
    @IBAction func didTapButton(_ sender: UIButton) {
        switch sender {
        case autobotsButton:
            self.team = .autobots
            delegate?.didSelect(self, .autobots)
        case decepticonsButton:
            self.team = .decepticons
            delegate?.didSelect(self, .decepticons)
        default:
            break
        }
    }
    
}
