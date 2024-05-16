//
//  GitHubAPIClient.swift
//  CleanArchitectureSample
//
//  Created by 岩本竜斗 on 2024/04/20.
//

import Foundation

protocol GitHubAPIClientProtocol {
    func searchRepository(keyword: String, perPage: Int, page: Int) async
}

final class GitHubAPIClient: GitHubAPIClientProtocol {
    private weak var gateway: GitHubRepositoryGatewayInput?
    
    private let base = "https://api.github.com"
    
    private let session = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    
    private let decoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    func inject(gateway: GitHubRepositoryGatewayInput) {
        self.gateway = gateway
    }
    
    func searchRepository(keyword: String, perPage: Int, page: Int) async {
        let path = "/search/repositories"
        
        guard var urlComponents = URLComponents(string: base + path) else { return }
        
        urlComponents.queryItems = [
            URLQueryItem(name: "q", value: keyword),
            URLQueryItem(name: "per_age", value: "\(perPage)"),
            URLQueryItem(name: "page", value: "\(page)")
        ]
        
        guard let url = urlComponents.url else { return }
        let request = URLRequest(url: url)
        
        do {
            let (data, _) = try await session.data(for: request)
            let response = try decoder.decode(GitHubAPIResponse<GitHubAPIRepository>.self, from: data)
            
            // GateWayに処理を伝える
            gateway?.searchRepository(repositories: response.items)
        } catch {
            print("Error: \(error)")
        }
    }
}
