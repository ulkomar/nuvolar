//
//  MockNetService.swift
//  nuvolarTests
//
//  Created by Developer on 10.06.24.
//

@testable import nuvolar
import Foundation

class MockNetService: NetServiceProtocol {
    var response: GitHubUsersModel.Response?
    var error: Error?
    
    func send<T: RequestAndResponse>(request: T) async throws -> T.Res {
        if let error = error {
            throw error
        }
        return response as! T.Res
    }
    
    func send<T>(request: T, url urlString: String) async throws -> T.Res where T : RequestAndResponse {
        if let error = error {
            throw error
        }
        return response as! T.Res
    }
}
