//
//  NetAwaitService.swift
//  nuvolar
//
//  Created by Developer on 6.06.24.
//

import UIKit
import Combine

final class NetAwaitService {
    
    // MARK: - Singleton
    
    static let shared = NetAwaitService()
    
    // MARK: - Private properties
    
    private let currentHostName = HOST.github
    private let decoder = JSONDecoder()
    
    // MARK: - Request
    
    @discardableResult
    public func send<T: RequestAndResponse>(request: T) async throws -> T.Res {
        guard let url = request.toUrl(host: currentHostName) else {
            throw NetworkErrors.badURL
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.methodRequest.rawValue
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw NetworkErrors.requestFailed
        }
        
        do {
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let decodedResponse = try decoder.decode(T.Res.self, from: data)
            return decodedResponse
        } catch {
            throw NetworkErrors.decodingFailed
        }
    }
    
    @discardableResult
    public func send<T: RequestAndResponse>(request: T, url urlString: String) async throws -> T.Res {
        guard let url = URL(string: urlString) else {
            throw NetworkErrors.badURL
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.methodRequest.rawValue
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw NetworkErrors.requestFailed
        }
        
        do {
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let decodedResponse = try decoder.decode(T.Res.self, from: data)
            return decodedResponse
        } catch {
            throw NetworkErrors.decodingFailed
        }
    }
    
}
