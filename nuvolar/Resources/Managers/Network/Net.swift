//
//  Net.swift
//  nuvolar
//
//  Created by Developer on 6.06.24.
//

protocol NetServiceProtocol {
    func send<T: RequestAndResponse>(request: T) async throws -> T.Res
    func send<T: RequestAndResponse>(request: T, url urlString: String) async throws -> T.Res
}

struct Net: NetServiceProtocol {
    @discardableResult
    func send<T: RequestAndResponse>(request: T) async throws -> T.Res {
        return try await NetAwaitService.shared.send(request: request)
    }
    
    @discardableResult
    func send<T: RequestAndResponse>(request: T, url urlString: String) async throws -> T.Res {
        return try await NetAwaitService.shared.send(request: request, url: urlString)
    }
}
