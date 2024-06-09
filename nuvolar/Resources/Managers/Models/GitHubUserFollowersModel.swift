//
//  GitHubUserFollowersModel.swift
//  nuvolar
//
//  Created by Developer on 7.06.24.
//

struct GitHubUserFollowersModel: RequestAndResponse {
    
    init() {}
    
    init(request: EmptyRequest?) {
        self.request = request
    }
    
    typealias Req = EmptyRequest
    typealias Res = [Follower]

    var request: EmptyRequest?
    var urlPostfix: String = ""
    var methodRequest: RequestMethod = .get

    struct EmptyRequest: Encodable {}

    struct Follower: Decodable {
        let login: String
        let id: Int
        let nodeId: String
        let avatarUrl: String
        let url: String
        let htmlUrl: String
        let followersUrl: String
        let followingUrl: String
        let gistsUrl: String
        let starredUrl: String
        let subscriptionsUrl: String
        let organizationsUrl: String
        let reposUrl: String
        let eventsUrl: String
        let receivedEventsUrl: String
        let type: String
        let siteAdmin: Bool
    }
}
