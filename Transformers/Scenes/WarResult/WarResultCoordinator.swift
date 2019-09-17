//
//  WarResultCoordinator.swift
//  Transformers
//
//  Created by Marco Parolin on 15/09/2019.
//  Copyright © 2019 Marco Parolin. All rights reserved.
//

import UIKit
import ServiceManager

class  WarResultCoordinator: BaseCoordinator {
    
    private var transformers: [Transformer]?
    
    func start(withTransformers transformers: [Transformer]) {
        super.start()
        let viewController = prepareTestViewController(withTransformers: transformers)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    private func prepareTestViewController(withTransformers transformers: [Transformer]) -> UIViewController {
        let viewModel = WarResultViewModel(withCoordinator: self, andTransformers: transformers)
        let viewController = WarResultViewController(withViewModel: viewModel)
        return viewController
    }
}
