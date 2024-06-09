//
//  GitHubUsersModel.swift
//  nuvolar
//
//  Created by Developer on 6.06.24.
//

struct GitHubUsersModel: RequestAndResponse {
    typealias Req = Request
    typealias Res = Response
    
    var request: Request?
    
    // MARK: - Initialization
    
    init(name: String, page: Int) {
        self.request = .init(q: name, page: page)
    }
    
    init(request: Request?) {
        self.request = request
    }
    
    // MARK: - Request & Response
    
    struct Request: Encodable {
        let q: String
        let page: Int
    }
    
    struct Response: Decodable {
        let totalCount: Int
        let items: [Item]
    }
    
    struct Item: Decodable {
        let login: String
        let id: Int
        let nodeId: String
        let avatarUrl: String
        let gravatarId: String
        let url, htmlUrl, followersUrl: String
        let followingUrl, gistsUrl, starredUrl: String
        let subscriptionsUrl, organizationsUrl, reposUrl: String
        let eventsUrl: String
        let receivedEventsUrl: String
        let type: String
        let siteAdmin: Bool
        let score: Int
    }
    
    // MARK: - Settings
    
    var urlPostfix = "/search/users"
    var methodRequest = RequestMethod.get
}
