//
//  URLBuilder.swift
//  nuvolar
//
//  Created by Developer on 7.06.24.
//

import Foundation

struct URLBuilder {
    var host: String
    var urlPostfix: String
    
    // Method to generate the URL
    func callAsFunction<T: Encodable>(with request: T) -> URL? {
        var components = URLComponents(string: host)
        components?.path = urlPostfix
        
        // Add query parameters
        let queryItems = request.toDictionary()?.compactMap { URLQueryItem(name: $0.key, value: $0.value) }
        components?.queryItems = queryItems
        
        return components?.url
    }
}

