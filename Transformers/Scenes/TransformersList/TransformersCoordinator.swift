//
//  TransformersCoordinator.swift
//  Transformers
//
//  Created by Marco Parolin on 14/09/2019.
//  Copyright © 2019 Marco Parolin. All rights reserved.
//

import UIKit
import ServiceManager

class TransformersCoordinator: BaseCoordinator {
    
    weak private var viewController: TransformersViewController?
    
    override func start() {
        super.start()
        let viewController = prepareTestViewController()
        self.pushFirst(viewController: viewController, animated: true)
    }
    
    private func prepareTestViewController() -> UIViewController {
        let viewModel = TransformersViewModel(withCoordinator: self)
        let viewController = TransformersViewController(withViewModel: viewModel)
        return viewController
    }
    
    // MARK: Navigation
    
    func addTransformer() {
        let newCoordinator = TransformerDetailCoordinator(navigationController: self.navigationController)
        self.startCoordinator(newCoordinator)
        let viewModel = TransformerDetailViewModel(withCoordinator: newCoordinator, andTransformer: nil)
        let viewController = TransformerDetailViewController(withViewModel: viewModel)
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func editTransformer(_ transformer: Transformer) {
        let newCoordinator = TransformerDetailCoordinator(navigationController: self.navigationController)
        self.startCoordinator(newCoordinator)
        let viewModel = TransformerDetailViewModel(withCoordinator: newCoordinator, andTransformer: transformer)
        let viewController = TransformerDetailViewController(withViewModel: viewModel)
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func goToBattle(_ transformers: [Transformer]) {
        let newCoordinator = WarResultCoordinator(navigationController: self.navigationController)
        self.startCoordinator(newCoordinator)
        let viewModel = WarResultViewModel(withCoordinator: newCoordinator, andTransformers: transformers)
        let viewController = WarResultViewController(withViewModel: viewModel)
        self.navigationController.pushViewController(viewController, animated: true)
    }
}
