//
//  GitHubUserFollowingModel+Domain.swift
//  nuvolar
//
//  Created by Developer on 9.06.24.
//


extension GitHubUserFollowingModel.Following: DomainMappable {
    var domain: String {
        login
    }
}
