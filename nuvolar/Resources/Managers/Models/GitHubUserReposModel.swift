//
//  GitHubUserReposModel.swift
//  nuvolar
//
//  Created by Developer on 9.06.24.
//

struct GitHubUserReposModel: RequestAndResponse {
    
    init() {}
    
    init(request: EmptyRequest?) {
        self.request = request
    }
    
    typealias Req = EmptyRequest
    typealias Res = [Repo]

    var request: EmptyRequest?
    var urlPostfix: String = ""
    var methodRequest: RequestMethod = .get

    struct EmptyRequest: Encodable {}

    struct Repo: Decodable {
        let name: String
    }
}

