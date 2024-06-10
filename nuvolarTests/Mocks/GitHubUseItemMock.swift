//
//  GitHubUseItemMock.swift
//  nuvolarTests
//
//  Created by Developer on 10.06.24.
//

@testable import nuvolar

extension GitHubUsersModel.Item {
    static func mockItem(id: Int) -> GitHubUsersModel.Item {
        return GitHubUsersModel.Item(
            login: "testUser\(id)",
            id: id,
            nodeId: "node\(id)",
            avatarUrl: "https://avatars.githubusercontent.com/u/\(id)?v=4",
            gravatarId: "",
            url: "https://api.github.com/users/testUser\(id)",
            htmlUrl: "https://github.com/testUser\(id)",
            followersUrl: "https://api.github.com/users/testUser\(id)/followers",
            followingUrl: "https://api.github.com/users/testUser\(id)/following{/other_user}",
            gistsUrl: "https://api.github.com/users/testUser\(id)/gists{/gist_id}",
            starredUrl: "https://api.github.com/users/testUser\(id)/starred{/owner}{/repo}",
            subscriptionsUrl: "https://api.github.com/users/testUser\(id)/subscriptions",
            organizationsUrl: "https://api.github.com/users/testUser\(id)/orgs",
            reposUrl: "https://api.github.com/users/testUser\(id)/repos",
            eventsUrl: "https://api.github.com/users/testUser\(id)/events{/privacy}",
            receivedEventsUrl: "https://api.github.com/users/testUser\(id)/received_events",
            type: "User",
            siteAdmin: false,
            score: 1
        )
    }
}

