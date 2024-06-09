//
//  RequestAndResponse.swift
//  nuvolar
//
//  Created by Developer on 6.06.24.
//

import UIKit

protocol RequestAndResponse {
    associatedtype Req: Encodable
    associatedtype Res: Decodable
    
    // MARK: - request params
    
    var urlPostfix: String { get }
    var methodRequest: RequestMethod { get }
    var request: Req? { get set }
    var response: Res.Type { get }
    
    // MARK: - init
    
    init(request: Req?)
    
    // MARK: - url params for request type of get
    
    func toUrl(host: String) -> URL?
}




extension RequestAndResponse {
    func toUrl(host: String) -> URL? {
        let urlBuilder = URLBuilder(host: host, urlPostfix: urlPostfix)
        return urlBuilder(with: request)
    }
    
    var response: Res.Type {
        Res.self
    }
}
