//
//  WarResultViewModel.swift
//  Transformers
//
//  Created by Marco Parolin on 15/09/2019.
//  Copyright © 2019 Marco Parolin. All rights reserved.
//

import UIKit
import ServiceManager

class WarResultViewModel: BaseViewModel<WarResultCoordinator> {
    
    var transformers: [Transformer]
    var battleResult: BattleResult?
    
    init(withCoordinator coordinator: WarResultCoordinator, andTransformers transformers: [Transformer]) {
        self.transformers = transformers
        super.init(withCoordinator: coordinator)
    }
    
    override func setup() {
        super.setup()
    }
    
    func setupBattle() {
        Battle.start(transformers, result: { [weak self] result in
            self?.battleResult = result
            self?.view?.dataLoaded()
        })
    }
    
}
