//
//  ItemDetailViewControllerSnapshotTests.swift
// ItemsAppTests
//
//  Created by Daniel Gallego Peralta on 19/12/21.
//

import XCTest
import ItemsTask
import ItemsApp

class ItemDetailViewControllerSnapshotTests: XCTestCase {

    override func setUp() {
        super.setUp()
        SnapshotTesting.insertIfNeeded(String(describing: ItemDetailViewControllerSnapshotTests.self), strategy: .assert)
    }

    func test_emptyView() {
        let sut = makeSUT()
        snapshotTest(snapshot: sut.snapshot(for: .iPhone13(style: .light)), named: "ITEMDETAILVIEWCONTROLLER_EMPTY_LIGHT")
    }
    
    func test_displayIsLoading() {
        let sut = makeSUT()
        sut.display(viewModel: LoadingViewModel(isLoading: true))
        snapshotTest(snapshot: sut.snapshot(for: .iPhone13(style: .light)), named: "ITEMDETAILVIEWCONTROLLER_DISPLAY_LOAD_LIGHT")
    }
    
    func test_hideIsLoading() {
        let sut = makeSUT()
        sut.display(viewModel: LoadingViewModel(isLoading: true))
        sut.display(viewModel: LoadingViewModel(isLoading: false))
        snapshotTest(snapshot: sut.snapshot(for: .iPhone13(style: .light)), named: "ITEMDETAILVIEWCONTROLLER_DISPLAY_NOLOAD_LIGHT")
    }
    
    func test_displayError() {
        let sut = makeSUT()
        sut.display(viewModel: ErrorViewModel.error(message: "Some error message"))
        snapshotTest(snapshot: sut.snapshot(for: .iPhone13(style: .light)), named: "ITEMDETAILVIEWCONTROLLER_DISPLAY_ERROR_LIGHT")
    }
    
    func test_hideError() {
        let sut = makeSUT()
        sut.display(viewModel: ErrorViewModel.error(message: "Some error message"))
        sut.display(viewModel: .noError)
        snapshotTest(snapshot: sut.snapshot(for: .iPhone13(style: .light)), named: "ITEMDETAILVIEWCONTROLLER_DISPLAY_NOERROR_LIGHT")
    }
    
    func test_displayItems() {
        let sut = makeSUT()
        sut.display(viewModel: makeItem())
        snapshotTest(snapshot: sut.snapshot(for: .iPhone13(style: .light)), named: "ITEMDETAILVIEWCONTROLLER_DISPLAY_ITEM_LIGHT")
    }
    
    //MARK: - Helpers
    
    private func makeSUT() -> ItemDetailViewController {
        let sut = ItemDetailViewController()
        return sut
    }
    
    private func makeItem() -> ItemDetailViewModel {
        return ItemDetailViewModel(
            title: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod",
            subtitle: "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
            date: "13/12/2021",
            body: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")
    }

}
