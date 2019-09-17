//
//  BaseCoordinator.swift
//  Transformers
//
//  Created by Marco Parolin on 14/09/2019.
//  Copyright © 2019 Marco Parolin. All rights reserved.
//

import UIKit

protocol BaseCoordinatorProtocol {
    func goBack(animated: Bool)
    func start()
}

class BaseCoordinator: NSObject, BaseCoordinatorProtocol {
    
    var navigationController: UINavigationController
  
    required init(navigationController navController: UINavigationController) {
        self.navigationController = navController
        super.init()
    }
    
    func startCoordinator(_ coord: BaseCoordinator) {
        coord.start()
    }
    
    func start() {}
    
    func goBack(animated: Bool = true) {
        if self.navigationController.presentedViewController != nil {
            self.navigationController.dismiss(animated: animated, completion: nil)
        } else {
            self.navigationController.popViewController(animated: animated)
        }
    }
    
    func pushFirst(viewController: UIViewController, animated: Bool = true) {
        self.navigationController.setViewControllers([viewController], animated: animated)
    }
    
}
