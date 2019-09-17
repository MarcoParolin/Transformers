//
//  TransformersViewController.swift
//  Transformers
//
//  Created by Marco Parolin on 14/09/2019.
//  Copyright © 2019 Marco Parolin. All rights reserved.
//

import UIKit

class TransformersViewController: BaseViewController<TransformersCoordinator, TransformersViewModel> {
    
    @IBOutlet weak var tableView: UITableView?
    @IBOutlet weak var goToWarButton: RoundedButton?
    @IBOutlet weak var searchBar: UISearchBar?
    
    override var leftNavigationButtons: [UIBarButtonItem] { return [UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editTableView))] }
    override var rightNavigationButtons: [UIBarButtonItem] { return [UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTransformer))] }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        goToWarButton?.setTitle("Let's battle".uppercased(), for: .normal)
        
        prepareSearchBar()
        setupTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.refreshTransformers()
    }
    
    // MARK: Setup
    private func prepareSearchBar() {
        searchBar?.placeholder = "Search"
        searchBar?.delegate = viewModel
    }
    
    private func setupTableView() {
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.register(UINib(nibName: R.nib.transformerTableViewCell.name, bundle: nil), forCellReuseIdentifier: "cellIdentifier")
    }
    override func dataLoaded() {
        super.dataLoaded()
        self.tableView?.reloadData()
        self.searchBar?.setShowsCancelButton(viewModel.cancelButton, animated: true)
        self.goToWarButton?.isEnabled = viewModel.warButtonEnabled
        self.goToWarButton?.alpha = viewModel.warButtonEnabled ? 1 : 0.5
    }
       
    // MARK: Listeners
    @objc private func editTableView() {
        if let isEditing = self.tableView?.isEditing {
            self.tableView?.setEditing(!isEditing, animated: true)
        }
    }
    
    @objc private func addTransformer() {
        self.viewModel.addTransformer()
    }
    
    override func searchBarDidCancel() {
        searchBar?.text = nil
        viewModel.searchBarText = ""
        searchBar?.showsCancelButton = false
        searchBar?.endEditing(true)
    }
    
    // MARK: Actions
    @IBAction func goToBattleAction(_ sender: Any) {
        viewModel.goToBattle()
    }
    
}

// MARK: - TableViewDelegate
extension TransformersViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.transformers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier") as? TransformerTableViewCell else {
            return UITableViewCell()
        }
        
        let transformer = viewModel.transformers[indexPath.row]
        cell.setup(transformer)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            viewModel.deleteTransformer(atIndex: indexPath.row)
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.editTransformer(atIndex: indexPath.row)
    }
    
}
