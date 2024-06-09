//
//  GitHubUserReposModel+Domain.swift
//  nuvolar
//
//  Created by Developer on 9.06.24.
//

extension GitHubUserReposModel.Repo: DomainMappable {
    var domain: String {
        name
    }
}
