//
//  LoadResourcePresenter.swift
//  SomeCompanyTask
//
//  Created by Daniel Gallego Peralta on 19/12/21.
//

import Foundation

public protocol LoadResourceLogic {
    associatedtype ResourceViewModel
    func display(viewModel: LoadingViewModel)
    func display(viewModel: ErrorViewModel)
    func display(viewModel: ResourceViewModel)
}

public final class LoadResourcePresenter<Resource, ResourceView: LoadResourceLogic> {
    public typealias Mapper = (Resource) -> ResourceView.ResourceViewModel
    
    private let view: ResourceView
    private let mapper: Mapper
    
    let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter
    }()
    
    public static var errorMessage: String {
        NSLocalizedString(
            "ERROR_LOADING_ITEMS",
            tableName: "Items",
            bundle: Bundle(for: Self.self),
            comment: "Error message when loading items fail")
    }
    
    public init(view: ResourceView, mapper: @escaping Mapper) {
        self.view = view
        self.mapper = mapper
    }
    
    public func didStartLoading() {
        view.display(viewModel: .noError)
        view.display(viewModel: LoadingViewModel(isLoading: true))
    }
    
    public func endLoading(with error: Error) {
        view.display(viewModel: LoadingViewModel(isLoading: false))
        view.display(viewModel: ErrorViewModel(message: Self.errorMessage))
    }
    
    public func endLoading(with resource: Resource) {
        view.display(viewModel: LoadingViewModel(isLoading: false))
        view.display(viewModel: mapper(resource))
    }
}
