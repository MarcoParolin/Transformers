//
//  TransformerTableViewCell.swift
//  Transformers
//
//  Created by Marco Parolin on 15/09/2019.
//  Copyright © 2019 Marco Parolin. All rights reserved.
//

import UIKit
import ServiceManager

class TransformerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel?
    @IBOutlet weak var icon: UIImageView?
    @IBOutlet weak var expertiseStackView: UIStackView?
    
    private var transformer: Transformer? {
        didSet {
            didUpdateTransformer()
        }
    }
    
    func setup(_ transformer: Transformer) {
        self.transformer = transformer
    }
    
    func didUpdateTransformer() {
        self.nameLabel?.text = self.transformer?.name
        self.icon?.image = transformer?.team?.icon
        if let team = transformer?.team {
            switch team {
            case .autobots:
                self.icon?.tintColor = Constants.autobotsColor
            case .decepticons:
                self.icon?.tintColor = Constants.decepticonsColor
            }
        }
        self.expertiseStackView?.arrangedSubviews.forEach { $0.removeFromSuperview() }
        transformer?.expertises.forEach {
            self.expertiseStackView?.addArrangedSubview(ExpertiseLabel(team: transformer?.team, expertise: $0))
        }
    }
}
