//
//  Net.swift
//  nuvolar
//
//  Created by Developer on 6.06.24.
//

struct Net {
    @discardableResult
    func send<T: RequestAndResponse>(request: T) async throws -> T.Res {
        return try await NetAwaitService.shared.send(request: request)
    }
    
    @discardableResult
    func send<T: RequestAndResponse>(request: T, url urlString: String) async throws -> T.Res {
        return try await NetAwaitService.shared.send(request: request, url: urlString)
    }
}
