//
//  GitHubAPIResponse.swift
//  CleanArchitectureSample
//
//  Created by 岩本竜斗 on 2024/04/20.
//

import Foundation

public struct GitHubAPIResponse<T: Decodable>: Decodable {
    public let totalCount: Int
    public let items: [T]
}
