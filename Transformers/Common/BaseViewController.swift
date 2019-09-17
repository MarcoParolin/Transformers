//
//  BaseViewController.swift
//  Transformers
//
//  Created by Marco Parolin on 14/09/2019.
//  Copyright © 2019 Marco Parolin. All rights reserved.
//

import UIKit

class BaseViewController<Coordinator: BaseCoordinator, ViewModel: BaseViewModel<Coordinator>>: UIViewController, BaseViewProtocol {
    
    var leftNavigationButtons: [UIBarButtonItem] { return [] }
    var rightNavigationButtons: [UIBarButtonItem] { return [] }
    
    var viewModel: ViewModel
    
    init(withViewModel viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.view.frame = CGRect(x: 0, y: 0, width: 375, height: 600)
        self.viewModel.view = self
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboardWhentappedOutside))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Not implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }
    
    // MARK: BaseViewProtocol
    func dataLoaded() {}
    
    func searchBarDidCancel() {}
    
    // MARK: Utils
    @objc func goBack() {
        self.viewModel.goBack()
    }
    
    /// Close the keyboard if a user tap outside
    @objc private func dismissKeyboardWhentappedOutside() {
        view.endEditing(true)
    }
    
    private func setupNavigationBar() {
        self.navigationItem.leftBarButtonItems = self.leftNavigationButtons
        self.navigationItem.rightBarButtonItems = self.rightNavigationButtons
    }

}
