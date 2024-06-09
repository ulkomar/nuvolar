//
//  GitHubUserInfoModel.swift
//  nuvolar
//
//  Created by Developer on 9.06.24.
//

import Foundation

struct GitHubUserInfoModel: RequestAndResponse {
    
    init() {}
    
    init(request: EmptyRequest?) {
        self.request = request
    }
    
    typealias Req = EmptyRequest
    typealias Res = Reponse

    var request: EmptyRequest?
    var urlPostfix: String = ""
    var methodRequest: RequestMethod = .get

    struct EmptyRequest: Encodable {}

    struct Reponse: Decodable {
        let name: String?
        let company: String?
        let createdAt: String
        let updatedAt: String
    }
}
