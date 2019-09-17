//
//  TransformerDetailViewModel.swift
//  Transformers
//
//  Created by Marco Parolin on 14/09/2019.
//  Copyright © 2019 Marco Parolin. All rights reserved.
//

import UIKit
import ServiceManager

enum DetailMode {
    case edit
    case add
}

class TransformerDetailViewModel: BaseViewModel<TransformerDetailCoordinator> {
    
    var transformer: Transformer
    var mode: DetailMode
    
    init(withCoordinator coordinator: TransformerDetailCoordinator, andTransformer transformer: Transformer?) {
        
        if let transformer = transformer {
            self.transformer = transformer
            self.mode = .edit
        } else {
            self.transformer = Transformer()
            self.mode = .add
        }
        
        super.init(withCoordinator: coordinator)
    }
    
    override func setup() {
       super.setup()
    }
    
    func saveTransformer() {
        switch mode {
        case .add:
            ServiceManager.shared.trasformers.create(transformer: transformer, completion: { [weak self] _ in
                self?.coordinator.goBack()
            }, failure: { error in
                // TODO: Show error alert
                print(error)
            })
        case .edit:
            ServiceManager.shared.trasformers.edit(transformer: transformer, completion: { [weak self] _ in
                self?.coordinator.goBack()
            }, failure: { error in
                // TODO: Show error alert
                print(error)
            })
        }
    }
    
}
