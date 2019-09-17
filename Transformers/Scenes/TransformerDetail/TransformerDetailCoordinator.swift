//
//  TransformerDetailCoordinator.swift
//  Transformers
//
//  Created by Marco Parolin on 14/09/2019.
//  Copyright © 2019 Marco Parolin. All rights reserved.
//

import UIKit
import ServiceManager

class TransformerDetailCoordinator: BaseCoordinator {
    
    private var transformer: Transformer?
    
    func start(withTransformer transformer: Transformer?) {
        super.start()
        let viewController = prepareTestViewController(withTransformer: transformer)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    private func prepareTestViewController(withTransformer transformer: Transformer?) -> UIViewController {
        let viewModel = TransformerDetailViewModel(withCoordinator: self, andTransformer: transformer)
        let viewController = TransformerDetailViewController(withViewModel: viewModel)
        return viewController
    }
    
}
