//
//  ItemsViewController.swift
// ItemsApp
//
//  Created by Daniel Gallego Peralta on 18/12/21.
//

import UIKit
import ItemsTask

public protocol ItemsViewControllerDelegate: AnyObject {
    func itemsViewController(_ viewController: ItemsViewController, didSelectItemId id: Int)
}

public final class ItemsViewController: UIViewController {
    public var load: (() -> Void)?
    public weak var delegate: ItemsViewControllerDelegate?
    
    private var items = [ItemViewModel]()
    
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
        tableView.register(cellType: ItemViewCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(tableView)
        tableView.fillInSafeArea(in: view)
    }
    
    private func setupLoadingIndicator() {
        view.addSubview(indicator)
        indicator.center(in: view)
    }
}

//MARK: - Input

extension ItemsViewController: LoadResourceLogic {
    public typealias ResourceViewModel = ItemsViewModel
    
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
    
    public func display(viewModel: ItemsViewModel) {
        items = viewModel.items
        tableView.reloadData()
    }
}

//MARK: - UITableView DataSource

extension ItemsViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ItemViewCell  = tableView.dequeueCell()
        cell.selectionStyle = .none
        let model = items[indexPath.row]
        cell.configure(with: model)
        return cell
    }
}

//MARK: - UITableView Delegate

extension ItemsViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard (0..<items.count).contains(indexPath.row) else { return }
        let id = items[indexPath.row].id
        delegate?.itemsViewController(self, didSelectItemId: id)
    }
}
