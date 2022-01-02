//
// ItemsAppTests.swift
// ItemsAppTests
//
//  Created by Daniel Gallego Peralta on 18/12/21.
//

import XCTest
import ItemsApp
import ItemsTask

class ItemsViewControllerTests: XCTestCase {

    func test_viewDidLoad_startLoader() {
        let (sut, loader) = makeSUT()
        XCTAssertEqual(loader.callCount, 0)
        sut.loadViewIfNeeded()
        XCTAssertEqual(loader.callCount, 1)
    }
    
    func test_displayLoading_showAndHideLoadingIndicator() {
        let (sut, _) = makeSUT()
        
        XCTAssertFalse(sut.isLoading)
        sut.display(viewModel: LoadingViewModel(isLoading: true))
        XCTAssert(sut.isLoading)
        
        sut.display(viewModel: LoadingViewModel(isLoading: false))
        XCTAssertFalse(sut.isLoading)
    }
    
    func test_displayError_showAndHideErrorView() {
        let (sut, _) = makeSUT()
        XCTAssertFalse(sut.isErrorVisible)
        
        sut.display(viewModel: ErrorViewModel.error(message: "Some error message"))
        XCTAssertTrue(sut.isErrorVisible)
        
        sut.display(viewModel: ErrorViewModel.noError)
        XCTAssertFalse(sut.isErrorVisible)
    }
    
    func test_displayItems_withNoItems_shouldDisplayEmptyList() {
        let (sut, _) = makeSUT()
        
        sut.display(viewModel: ItemsViewModel(items: []))
        XCTAssertEqual(sut.numberOfRows, 0)
    }
    
    func test_displayItems_withOneItems_shouldRenderOneItem() {
        let (sut, _) = makeSUT()
        sut.loadViewIfNeeded()
        let item = makeItem()
        
        XCTAssertEqual(sut.numberOfRows, 0)
        sut.display(viewModel: ItemsViewModel(items: [item]))
        
        XCTAssertEqual(sut.numberOfRows, 1)
        assert(cell: sut.cell(at: 0), with: item)
    }
    
    func test_displayItems_withMultipleItems_shouldRenderMultipleItems() {
        let (sut, _) = makeSUT()
        sut.loadViewIfNeeded()
        let items = makeItems()
        
        sut.display(viewModel: ItemsViewModel(items: items))
        XCTAssertEqual(sut.numberOfRows, items.count)
        
        for (index, item) in items.enumerated() {
            assert(cell: sut.cell(at: index), with: item)
        }
    }
    
    func test_displayItems_withNoItemsWithItemsAlreadyDisplayed_shouldRemoveItems() {
        let (sut, _) = makeSUT()
        sut.loadViewIfNeeded()
        let items = makeItems()
        sut.display(viewModel: ItemsViewModel(items: items))
        XCTAssertEqual(sut.numberOfRows, items.count)
        sut.display(viewModel: ItemsViewModel(items: []))
        XCTAssertEqual(sut.numberOfRows, 0)
    }
    
    func assert(cell: ItemViewCell, with item: ItemViewModel, file: StaticString = #file, line: UInt = #line) {
        XCTAssertEqual(cell.title, item.title, "Title", file: file, line: line)
        XCTAssertEqual(cell.subtitle, item.subtitle, "Subtitle", file: file, line: line)
        XCTAssertEqual(cell.date, item.date, "Date", file: file, line: line)
    }
    
    func test_didSelect_shouldCallDidSelectItem() {
        let (sut, _) = makeSUT()
        let coordinatorSpy = CoordinatorSpy()
        sut.delegate = coordinatorSpy
        sut.loadViewIfNeeded()
        
        let items = makeItems()
        let indexToSelect: Int = 0
        let id = items[indexToSelect].id
        
        sut.display(viewModel: ItemsViewModel(items: items))
        sut.select(at: indexToSelect)
        
        XCTAssertEqual(coordinatorSpy.messages, [.routeToItemDetail(id)])
    }
    
    //MARK: - Helpers
    
    private func makeSUT(file: StaticString = #file, line: UInt = #line) -> (ItemsViewController, LoaderSpy) {
        let loader = LoaderSpy()
        let sut = ItemsViewController()
        sut.load = loader.load
        tracksForMemoryLeaks(sut, file: file, line: line)
        tracksForMemoryLeaks(loader, file: file, line: line)
        return (sut, loader)
    }
    
    private func makeItem(id: Int = 0, title: String = "a title", subtitle: String = "a subtitle", date: String = "12/05/2021") -> ItemViewModel {
        return .init(id: id, title: title, subtitle: subtitle, date: date)
    }
            
    private func makeItems() -> [ItemViewModel] {
        return [
            makeItem(id: 0),
            makeItem(
                id: 1,
                title: "another title",
                subtitle: "another subtitle",
                date: "13/06/2020"),
            makeItem(
                id: 2,
                title: "third title",
                subtitle: "third subtitle",
                date: "19/01/2020")
        ]
    }
    
    private class LoaderSpy {
        private(set) var callCount = 0
        
        func load() {
            callCount += 1
        }
    }
    
    private class CoordinatorSpy: ItemsViewControllerDelegate {
        enum Message: Equatable {
            case routeToItemDetail(Int)
        }
        
        var messages = [Message]()
        
        func itemsViewController(_ viewController: ItemsViewController, didSelectItemId id: Int) {
            messages.append(.routeToItemDetail(id))
        }
    }

}
