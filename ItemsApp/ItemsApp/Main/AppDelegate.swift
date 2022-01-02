//
//  AppDelegate.swift
// ItemsApp
//
//  Created by Daniel Gallego Peralta on 18/12/21.
//

import UIKit
import ItemsTask

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var coordinator: MainCoordinator?
    
    static var baseURL: URL = {
        return URL(string: "http://danieldgp.es")!
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configureWindow()
        return true
    }
    
    private func configureWindow() {
        let navVC = UINavigationController()
        coordinator = MainCoordinator(navigationController: navVC)
        coordinator?.start()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navVC
        window?.makeKeyAndVisible()
    }
    
    static func makeItemsLoader() -> ResourceLoader<[Item]> {
        let url = ItemEndpoint.getAll.url(baseURL: AppDelegate.baseURL)
        let client = URLSessionHTTPClient()
        let loader = ResourceLoader(url: url, client: client, mapper: ItemsMapper.map)
        return loader
    }
    
    static func makeItemDetailLoader(itemID: Int) -> ResourceLoader<Item> {
        let url = ItemEndpoint.get(itemID).url(baseURL: AppDelegate.baseURL)
        let client = URLSessionHTTPClient()
        let loader = ResourceLoader(url: url, client: client, mapper: ItemDetailMapper.map)
        return loader
    }
}
