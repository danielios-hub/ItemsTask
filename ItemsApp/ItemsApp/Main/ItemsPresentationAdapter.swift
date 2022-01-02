//
//  ItemsPresentationAdapter.swift
// ItemsApp
//
//  Created by Daniel Gallego Peralta on 18/12/21.
//

import Foundation
import ItemsTask

public final class ItemsPresentationAdapter<Resource, ResourceView: LoadResourceLogic> {
    private let presenter: LoadResourcePresenter<Resource, ResourceView>
    private let loader:  ResourceLoader<Resource>
    
    public init(presenter: LoadResourcePresenter<Resource, ResourceView>, loader: ResourceLoader<Resource>) {
        self.presenter = presenter
        self.loader = loader
    }
    
    public func load() {
        presenter.didStartLoading()
        
        loader.load { [weak presenter] result in
            guard let presenter = presenter else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let items):
                    presenter.endLoading(with: items)
                case .failure(let error):
                    presenter.endLoading(with: error)
                }
            }
        }
    }
}
