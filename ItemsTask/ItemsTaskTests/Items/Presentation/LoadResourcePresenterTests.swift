//
//  LoadResourcePresenterTests.swift
//  SomeCompanyTaskTests
//
//  Created by Daniel Gallego Peralta on 19/12/21.
//

import XCTest
import ItemsTask

class LoadResourcePresenterTests: XCTestCase {
    
    func test_init_doesNotSendMessageToView() {
        let (_, spy) = makeSUT()
        XCTAssert(spy.messages.isEmpty)
    }
    
    func test_startLoading_callStartLoadingWithNoError() {
        let (sut, spy) = makeSUT()
        sut.didStartLoading()
        XCTAssertEqual(spy.messages, [
            .error(false),
            .isLoading(true)])
    }
    
    func test_endLoading_withError_callEndLoadingAndDisplayError() {
        let (sut, spy) = makeSUT()
        
        sut.endLoading(with: anyNSError())
        XCTAssertEqual(spy.messages, [
            .isLoading(false),
            .error(true)
        ])
    }
    
    func test_endLoading_withItems_callEndLoadingAndDisplayItems() {
        let (sut, spy) = makeSUT()
        let items: [Item] = makeItems().items.map { $0.model }
        
        let expectedViewModel: ItemsViewModel = ItemsViewModel(items: [
            .init(id: 0, title: "a title", subtitle: "a subtitle", date: "28/08/2020"),
            .init(id: 1, title: "another title", subtitle: "another subtitle", date: "01/11/2021")
        ])
        
        sut.endLoading(with: items)
        XCTAssertEqual(spy.messages, [
            .isLoading(false),
            .showItems(expectedViewModel.items)
        ])
    }
    
    //MARK: - Helpers
    
    private func makeSUT() -> (LoadResourcePresenter<[Item], ResourceViewSpy>, ResourceViewSpy) {
        let spy = ResourceViewSpy()
        let sut = LoadResourcePresenter<[Item], ResourceViewSpy>(view: spy, mapper: ItemsPresenter.map)
        tracksForMemoryLeaks(sut)
        return (sut, spy)
    }
    
    private class ResourceViewSpy: LoadResourceLogic {
        enum Message: Equatable {
            case isLoading(Bool)
            case error(Bool)
            case noError
            case showItems([ItemViewModel])
        }
        
        typealias ResourceViewModel = ItemsViewModel
        private(set) var messages = [Message]()
        
        func display(viewModel: LoadingViewModel) {
            messages.append(.isLoading(viewModel.isLoading))
        }
        
        func display(viewModel: ErrorViewModel) {
            messages.append(.error(viewModel.message != nil))
        }
        
        func display(viewModel: ItemsViewModel) {
            messages.append(.showItems(viewModel.items))
        }
    }

}
