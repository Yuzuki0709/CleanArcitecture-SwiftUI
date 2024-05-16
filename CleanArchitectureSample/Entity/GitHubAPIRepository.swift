//
//  GitHubAPIRepository.swift
//  CleanArchitectureSample
//
//  Created by 岩本竜斗 on 2024/04/20.
//

import Foundation

public struct GitHubAPIRepository: Decodable {
    public let id             : Int
    public let name           : String
    public let fullName       : String
    public let owner          : GitHubAPIOwner
    public let description    : String?
    public let createdAt      : Date
    public let updatedAt      : Date
    public let homepage       : String?
    public let size           : Int
    public let stargazersCount: Int
    public let watchersCount  : Int
    public let language       : String?
    public let forksCount     : Int
    public let openIssuesCount: Int
}

extension GitHubAPIRepository: Equatable {
    public static func == (lhs: GitHubAPIRepository, rhs: GitHubAPIRepository) -> Bool {
        lhs.id == rhs.id
    }
}

extension GitHubAPIRepository: Identifiable {}
