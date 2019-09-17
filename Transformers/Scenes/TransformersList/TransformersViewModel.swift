//
//  TransformersViewModel.swift
//  Transformers
//
//  Created by Marco Parolin on 14/09/2019.
//  Copyright © 2019 Marco Parolin. All rights reserved.
//

import UIKit
import ServiceManager

class TransformersViewModel: BaseViewModel<TransformersCoordinator> {
    
    // MARK: - Variables
    var transformers: [Transformer] {
        return _transformers.filter {
            guard !searchBarText.isEmpty else { return true}
            return $0.name?.contains(searchBarText) ?? false
        }
    }
    private var _transformers: [Transformer] = [] {
        didSet {
            self.view?.dataLoaded()
        }
    }
    var searchBarText: String = ""
    var cancelButton: Bool {
        return !searchBarText.isEmpty
    }
    var warButtonEnabled: Bool {
        let hasAutobots: Bool = transformers.contains(where: { $0.team == .autobots })
        let hasDecepticons: Bool = transformers.contains(where: { $0.team == .decepticons })
        return hasAutobots && hasDecepticons
    }
    
    override func setup() {
       super.setup()
        self.getTransformers()
    }
    // MARK: - Services
    private func getTransformers() {
        // First get transformers from Core Data
        self._transformers = ServiceManager.shared.trasformers.fetchLocal()
        // Then tries to get them from remote
        refreshTransformers()
    }
    
    func refreshTransformers() {
        ServiceManager.shared.trasformers.get(id: nil, completion: { [weak self] (result) in
            guard let transformers = result else { return }
            self?._transformers = transformers
        }, failure: { (error) in
            print("Error getting transformers: \(error)")
        })
    }
    
    func deleteTransformer(atIndex index: Int) {
        
        guard index < transformers.count else { return }
        let transformer = transformers[index]
        guard let id = transformer.id else { return }
        _transformers.removeAll(where: { $0.id == transformer.id })
        
        ServiceManager.shared.trasformers.delete(id: id, completion: { (transformers) in
            self._transformers = transformers
        }, failure: { (error) in
            print(error)
        })
    }
    func editTransformer(atIndex index: Int) {
        guard index < transformers.count else { return }
        let transformer = transformers[index]
        self.coordinator.editTransformer(transformer)
    }
    
    // MARK: Navigation
    func addTransformer() {
        self.coordinator.addTransformer()
    }
    
    func goToBattle() {
        self.coordinator.goToBattle(self.transformers)
    }
}

// MARK: - SearchBar Delegate
extension TransformersViewModel: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBarText = searchText
        self.view?.dataLoaded()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.view?.searchBarDidCancel()
        self.view?.dataLoaded()
    }
}
