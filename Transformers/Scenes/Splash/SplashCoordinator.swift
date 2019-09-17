//
//  SplashCoordinator.swift
//  Transformers
//
//  Created by Marco Parolin on 14/09/2019.
//  Copyright © 2019 Marco Parolin. All rights reserved.
//

import UIKit
import ServiceManager

class SplashCoordinator: BaseCoordinator {
    
    override func start() {
        super.start()
        let viewModel = SplashViewModel(withCoordinator: self)
        let viewController = SplashViewController(withViewModel: viewModel)
        self.navigationController.isNavigationBarHidden = true
        self.navigationController.viewControllers = [viewController]
        self.setupApplication()
    }
    
    func setupApplication() {
        ServiceManager.shared.login.getToken(completion: { [weak self] in
            self?.startUpApplication()
        }, failure: { (error) in
            print("Failed to get token: \(error.localizedDescription)")
        })
    }
    
    func startUpApplication() {
        self.navigationController.isNavigationBarHidden = false
        let coordinator = TransformersCoordinator(navigationController: self.navigationController)
        coordinator.start()
    }

}
