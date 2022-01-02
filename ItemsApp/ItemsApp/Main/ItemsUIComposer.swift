//
//  ItemsUIComposer.swift
// ItemsApp
//
//  Created by Daniel Gallego Peralta on 18/12/21.
//

import UIKit
import ItemsTask

class ItemsUIComposer {
    
    public static func makeItemsScene(with loader: ResourceLoader<[Item]>) -> ItemsViewController {
        let viewController = ItemsViewController()
        let presenter = LoadResourcePresenter(view: viewController, mapper: ItemsPresenter.map)
        let adapter = ItemsPresentationAdapter(presenter: presenter, loader: loader)
        viewController.load = adapter.load
        return viewController
    }
    
    public static func makeItemDetailScene(with loader: ResourceLoader<Item>) -> ItemDetailViewController {
        let viewController = ItemDetailViewController()
        let presenter = LoadResourcePresenter(view: viewController, mapper: ItemDetailPresenter.map)
        let adapter = ItemsPresentationAdapter(presenter: presenter, loader: loader)
        viewController.load = adapter.load
        return viewController
    }
}
