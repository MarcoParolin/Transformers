//
//  WarResultViewController.swift
//  Transformers
//
//  Created by Marco Parolin on 15/09/2019.
//  Copyright © 2019 Marco Parolin. All rights reserved.
//

import UIKit
import ServiceManager

class WarResultViewController: BaseViewController<WarResultCoordinator, WarResultViewModel> {
    
    @IBOutlet weak var winnerIcon: UIImageView?
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var matchStackView: UIStackView?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.setupBattle()
    }

    override func dataLoaded() {
        super.dataLoaded()
        DispatchQueue.main.async { [weak self] in
            if let winningTeam = self?.viewModel.battleResult?.winner {
                switch winningTeam {
                case .autobots:
                    self?.winnerIcon?.image = R.image.autobotsIcon()
                    self?.winnerIcon?.tintColor = Constants.autobotsColor
                    self?.titleLabel?.text = "Autobots won"
                case .decepticons:
                    self?.winnerIcon?.image = R.image.decepticonsIcon()
                    self?.winnerIcon?.tintColor = Constants.decepticonsColor
                    self?.titleLabel?.text = "Decepticons won"
                }
            } else {
                self?.winnerIcon?.isHidden = true
                self?.titleLabel?.text = "Everyone got destroyed"
            }
            self?.setupStackView(self?.viewModel.battleResult?.matchResults ?? [] )
        }
    }
    
    private func setupStackView(_ matchResults: [MatchResult]) {
        self.matchStackView?.arrangedSubviews.forEach { $0.removeFromSuperview() }
        for result in matchResults {
            let label = MatchResultLabel()
            switch result.reason {
            case .destroyed:
                label.text = "\(result.winner?.name ?? "") destroyed \(result.losers.asString)"
            case .fleed:
                label.text = "\(result.losers.asString) fleed from \(result.winner?.name ?? "")"
            case .instaWin:
                label.text = "\(result.winner?.name ?? "") dominated \(result.losers.asString)"
            case .outskilled:
                label.text = "\(result.winner?.name ?? "") outskilled \(result.losers.asString)"
            case .tie:
                label.text = "\(result.losers.asString) went too far)"
            case .totalAnnihilation:
                print("You shouldn't be here")
            }
            self.matchStackView?.addArrangedSubview(label)
        }
    }
    
    @IBAction func deleteTokenAction(_ sender: Any) {
        // This button exists for testing purposes
        ServiceManager.shared.login.clearToken()
    }
    
}

private extension Array where Element == Transformer {
    /// Generate a formatted string for losing transformers
    var asString: String {
        guard self.count > 1 else { return "\(self.first?.name ?? "")"}
        var strArr =  self.map({ $0.name ?? "" })
        let lastElement = strArr.removeLast()
        return strArr.joined(separator: ", ") + " and \(lastElement)"
    }
}
