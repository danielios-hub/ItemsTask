//
//  ItemDetailViewControllerTests.swift
// ItemsAppTests
//
//  Created by Daniel Gallego Peralta on 19/12/21.
//

import XCTest
import ItemsTask
import ItemsApp

class ItemDetailViewControllerTests: XCTestCase {

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
    
    func test_displayItem_shouldRenderItemDetail() {
        let (sut, _) = makeSUT()
        sut.loadViewIfNeeded()
        let item = makeItemDetail()
        
        XCTAssertEqual(sut.numberOfRows, 0)
        sut.display(viewModel: item)
        
        XCTAssertEqual(sut.numberOfRows, 1)
        assert(cell: sut.cell(at: 0), with: item)
    }
    
    func assert(cell: ItemDetailViewCell, with item: ItemDetailViewModel, file: StaticString = #file, line: UInt = #line) {
        XCTAssertEqual(cell.title, item.title, "Title", file: file, line: line)
        XCTAssertEqual(cell.subtitle, item.subtitle, "Subtitle", file: file, line: line)
        XCTAssertEqual(cell.date, item.date, "Date", file: file, line: line)
        XCTAssertEqual(cell.body, item.body, "Date", file: file, line: line)
    }
    
    //MARK: - Helpers
    
    private func makeSUT(file: StaticString = #file, line: UInt = #line) -> (ItemDetailViewController, LoaderSpy) {
        let loader = LoaderSpy()
        let sut = ItemDetailViewController()
        sut.load = loader.load
        tracksForMemoryLeaks(sut, file: file, line: line)
        tracksForMemoryLeaks(loader, file: file, line: line)
        return (sut, loader)
    }
    
    private func makeItemDetail(title: String = "a title", subtitle: String = "a subtitle", date: String = "12/05/2021", body: String? = "a body") -> ItemDetailViewModel {
        return .init(title: title, subtitle: subtitle, date: date, body: body)
    }
    
    private class LoaderSpy {
        private(set) var callCount = 0
        
        func load() {
            callCount += 1
        }
    }

}
