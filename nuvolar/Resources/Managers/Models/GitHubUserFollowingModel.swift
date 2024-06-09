//
//  GitHubUserFollowingModel.swift
//  nuvolar
//
//  Created by Developer on 9.06.24.
//

struct GitHubUserFollowingModel: RequestAndResponse {
    
    init() {}
    
    init(request: EmptyRequest?) {
        self.request = request
    }
    
    typealias Req = EmptyRequest
    typealias Res = [Following]

    var request: EmptyRequest?
    var urlPostfix: String = ""
    var methodRequest: RequestMethod = .get

    struct EmptyRequest: Encodable {}

    struct Following: Decodable {
        let login: String
    }
}

