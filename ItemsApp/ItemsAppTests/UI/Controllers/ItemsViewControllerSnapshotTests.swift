//
//  ItemsViewControllerSnapshotTests.swift
// ItemsAppTests
//
//  Created by Daniel Gallego Peralta on 19/12/21.
//

import XCTest
import ItemsTask
import ItemsApp

class ItemsViewControllerSnapshotTests: XCTestCase {

    override func setUp() {
        super.setUp()
        SnapshotTesting.insertIfNeeded(String(describing: ItemsViewControllerSnapshotTests.self), strategy: .assert)
    }

    func test_emptyView() {
        let sut = makeSUT()
        snapshotTest(snapshot: sut.snapshot(for: .iPhone13(style: .light)), named: "ITEMSVIEWCONTROLLER_EMPTY_LIGHT")
    }
    
    func test_displayIsLoading() {
        let sut = makeSUT()
        sut.display(viewModel: LoadingViewModel(isLoading: true))
        snapshotTest(snapshot: sut.snapshot(for: .iPhone13(style: .light)), named: "ITEMSVIEWCONTROLLER_DISPLAY_LOAD_LIGHT")
    }
    
    func test_hideIsLoading() {
        let sut = makeSUT()
        sut.display(viewModel: LoadingViewModel(isLoading: true))
        sut.display(viewModel: LoadingViewModel(isLoading: false))
        snapshotTest(snapshot: sut.snapshot(for: .iPhone13(style: .light)), named: "ITEMSVIEWCONTROLLER_DISPLAY_NOLOAD_LIGHT")
    }
    
    func test_displayError() {
        let sut = makeSUT()
        sut.display(viewModel: ErrorViewModel.error(message: "Some error message"))
        snapshotTest(snapshot: sut.snapshot(for: .iPhone13(style: .light)), named: "ITEMSVIEWCONTROLLER_DISPLAY_ERROR_LIGHT")
    }
    
    func test_hideError() {
        let sut = makeSUT()
        sut.display(viewModel: ErrorViewModel.error(message: "Some error message"))
        sut.display(viewModel: .noError)
        snapshotTest(snapshot: sut.snapshot(for: .iPhone13(style: .light)), named: "ITEMSVIEWCONTROLLER_DISPLAY_NOERROR_LIGHT")
    }
    
    func test_displayItems() {
        let sut = makeSUT()
        let items = [
            makeItem(id: 0),
            makeItem(
                id: 1,
                title: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod",
                subtitle: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
                date: "13/12/2021"),
            makeItem(
                id: 2,
                title: "third title",
                subtitle: "third subtitle",
                date: "19/01/2020")]
        sut.display(viewModel: .init(items: items))
        snapshotTest(snapshot: sut.snapshot(for: .iPhone13(style: .light)), named: "ITEMSVIEWCONTROLLER_DISPLAY_ITEMS_LIGHT")
    }
    
    //MARK: - Helpers
    
    private func makeSUT() -> ItemsViewController {
        let sut = ItemsViewController()
        return sut
    }
    
    private func makeItem(id: Int, title: String = "a title", subtitle: String = "a subtitle", date: String = "12/05/2021") -> ItemViewModel {
        return .init(id: id, title: title, subtitle: subtitle, date: date)
    }
}
