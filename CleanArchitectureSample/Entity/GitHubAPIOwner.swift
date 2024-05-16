//
//  GitHubAPIOwner.swift
//  CleanArchitectureSample
//
//  Created by 岩本竜斗 on 2024/04/20.
//

import Foundation

public struct GitHubAPIOwner: Decodable {
    public let login    : String
    public let avatarUrl: String
}
