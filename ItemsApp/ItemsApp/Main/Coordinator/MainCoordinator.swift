//
//  MainCoordinator.swift
// ItemsApp
//
//  Created by Daniel Gallego Peralta on 19/12/21.
//

import UIKit

final class MainCoordinator: NSObject, Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let loader = AppDelegate.makeItemsLoader()
        let viewController = ItemsUIComposer.makeItemsScene(with: loader)

        viewController.delegate = self
        navigationController.delegate = self
        navigationController.pushViewController(viewController, animated: true)
    }

    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
}

extension MainCoordinator: UINavigationControllerDelegate {
    func navigationController(
        _ navigationController: UINavigationController,
        didShow viewController: UIViewController, animated: Bool) {}
}

//MARK: - ItemsViewControllerDelegate

extension MainCoordinator: ItemsViewControllerDelegate {
    func itemsViewController(_ viewController: ItemsViewController, didSelectItemId id: Int) {
        let loader = AppDelegate.makeItemDetailLoader(itemID: id)
        let viewController = ItemsUIComposer.makeItemDetailScene(with: loader)
        navigationController.pushViewController(viewController, animated: true)
    }
}
