//
//  DetailedSearchUserViewModelTests.swift
//  nuvolarTests
//
//  Created by Developer on 10.06.24.
//

import XCTest
import Combine
@testable import nuvolar

final class DetailedSearchUserViewModelTests: XCTestCase {
    
    private var viewModel: DetailedSearchUserViewModel!
    private var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        let user = GitHubUsersModel.Item.mockItem(id: 1)
        viewModel = DetailedSearchUserViewModel(user: user)
        cancellables = []
    }
    
    override func tearDown() {
        viewModel = nil
        cancellables = nil
        super.tearDown()
    }
    
    func testPrepareForDisplayint() async throws {
        
        let stateExpectation = expectation(description: "State updated with user profile image")
        
        viewModel.state
            .sink { state in
                stateExpectation.fulfill()
            }
            .store(in: &cancellables)
        
        viewModel.prepareForDisplayint()
        
        await fulfillment(of: [stateExpectation], timeout: 1)
    }
}
