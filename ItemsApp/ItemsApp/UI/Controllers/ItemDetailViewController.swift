//
//  ItemDetailViewController.swift
// ItemsApp
//
//  Created by Daniel Gallego Peralta on 19/12/21.
//

import UIKit
import ItemsTask

public final class ItemDetailViewController: UIViewController {
    public var load: (() -> Void)?
    var item: ItemDetailViewModel?
    
    public let indicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.hidesWhenStopped = true
        return view
    }()
    
    public let tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.separatorStyle = .none
        return view
    }()
    
    private(set) public var errorView: UIView?
    
    //MARK: - Life cicle
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTableView()
        setupLoadingIndicator()
        load?()
    }
    
    //MARK: - Setup
    
    private func setupView() {
        view.backgroundColor = UIColor.primaryBackground
    }
    
    private func setupTableView() {
        tableView.register(cellType: ItemDetailViewCell.self)
        tableView.dataSource = self
        
        view.addSubview(tableView)
        tableView.fillInSafeArea(in: view)
    }
    
    private func setupLoadingIndicator() {
        view.addSubview(indicator)
        indicator.center(in: view)
    }
}

//MARK: - Input

extension ItemDetailViewController: LoadResourceLogic {
    public typealias ResourceViewModel = ItemDetailViewModel
    
    public func display(viewModel: LoadingViewModel) {
        viewModel.isLoading ? indicator.startAnimating() : indicator.stopAnimating()
    }
    
    public func display(viewModel: ErrorViewModel) {
        if let error = viewModel.message {
            let frame = CGRect(
                origin: .zero,
                size: .init(width: tableView.frame.width, height: 40))
            errorView = ErrorView(message: error, frame: frame)
        } else {
            errorView = nil
        }
        
        tableView.tableHeaderView = errorView
    }
    
    public func display(viewModel: ItemDetailViewModel) {
        item = viewModel
        tableView.reloadData()
    }
}

//MARK: - UITableView DataSource

extension ItemDetailViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return item != nil ? 1 : 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ItemDetailViewCell  = tableView.dequeueCell()
        cell.selectionStyle = .none
        if let item = item {
            cell.configure(with: item)
        }
        return cell
    }
}
