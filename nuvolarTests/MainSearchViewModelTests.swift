//
//  MainSearchViewModelTests.swift
//  nuvolarTests
//
//  Created by Developer on 10.06.24.
//

import XCTest
import Combine
@testable import nuvolar

final class MainSearchViewModelTests: XCTestCase {
    
    private var viewModel: MainSearchViewModel!
    private var mockNetService: MockNetService!
    private var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        mockNetService = MockNetService()
        viewModel = MainSearchViewModel(netServices: mockNetService)
        cancellables = []       
    }
    
    override func tearDown() {
        viewModel = nil
        cancellables = nil
        super.tearDown()
    }
    
    func testSearchingFieldStatedChanged() throws {
        let stateExpectation = expectation(description: "State updated to searchingModeShowing")
        
        viewModel.state
            .sink { state in
                if case .searchingModeShowing = state {
                    stateExpectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        viewModel.searchingFieldStatedChanged(isFocused: true)
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testCancellSearchButtonTapped() throws {        
        let stateExpectation = expectation(description: "State updated with empty user models")
        
        viewModel.state
            .sink { state in
                if case .updateModels(let models) = state, models.isEmpty {
                    stateExpectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        viewModel.cancellSearchButtonTapped()
        
        waitForExpectations(timeout: 1, handler: nil)
    }
}
