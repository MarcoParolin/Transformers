//
//  BaseViewModel.swift
//  Transformers
//
//  Created by Marco Parolin on 14/09/2019.
//  Copyright © 2019 Marco Parolin. All rights reserved.
//

import UIKit

protocol BaseViewProtocol: AnyObject {
    func dataLoaded()
    func goBack()
    func searchBarDidCancel()
}

class BaseViewModel<Coordinator: BaseCoordinator>: NSObject {
    
    weak var view: BaseViewProtocol?
    
    var coordinator: Coordinator
    
    init(withCoordinator coordinator: Coordinator) {
        self.coordinator = coordinator
        super.init()
        self.setup()
    }
    
    func setup() {}
    
    func goBack(animated: Bool = true) {
        self.coordinator.goBack(animated: animated)
    }
    
}
