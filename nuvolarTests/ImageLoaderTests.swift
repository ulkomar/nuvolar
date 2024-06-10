//
//  DetailedSearchUserViewModelTests.swift
//  nuvolarTests
//
//  Created by Developer on 9.06.24.
//

import XCTest
import Combine
@testable import nuvolar

final class MockImageLoader: ImageLoaderProtocol {
    
    var shouldSucceed: Bool = true // Flag to control whether the mock should succeed or fail
    
    init(shouldSucceed: Bool) {
        self.shouldSucceed = shouldSucceed
    }
    
    func loadImage(from urlString: String) async -> UIImage? {
        if shouldSucceed {
            return UIImage(systemName: "pencil")
        } else {
            return nil
        }
    }
}

final class MockImageLoaderSUT {
    func testSUT(shouldSucceed: Bool) async -> UIImage? {
        let mockImageLoader = MockImageLoader(shouldSucceed: shouldSucceed)
        return await mockImageLoader.loadImage(from: "")
    }
}


class MockImageLoaderTests: XCTestCase {
    
    private var sut: MockImageLoaderSUT!
    
    override func setUp() {
        super.setUp()
        sut = MockImageLoaderSUT()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testLoadImageSuccess() async {
        // Given
        
        // When
        let image = await sut.testSUT(shouldSucceed: true)
        
        // Then
        XCTAssertNotNil(image, "Image should not be nil when loading succeeds")
    }
    
    func testLoadImageFailure() async {
        // Given
        let image = await sut.testSUT(shouldSucceed: false)
        
        // Then
        XCTAssertNil(image, "Image should be nil when loading fails")
    }
}
