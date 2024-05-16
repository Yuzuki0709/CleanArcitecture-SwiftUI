//
//  GitHubRepositoryGateway.swift
//  CleanArchitectureSample
//
//  Created by 岩本竜斗 on 2024/04/20.
//

import Foundation

protocol GitHubRepositoryGatewayProtocol {
    func searchRepository(keyword: String, perPage: Int, page: Int) async
}

protocol GitHubRepositoryGatewayInput: AnyObject {
    func searchRepository(repositories: [GitHubAPIRepository])
}

final class GitHubRepositoryGateway: GitHubRepositoryGatewayProtocol {
    private weak var useCase: GitHubRepositoryUseCaseInput?
    private let dataSouce: GitHubAPIClientProtocol
    
    init(dataSouce: GitHubAPIClientProtocol) {
        self.dataSouce = dataSouce
    }
    
    func inject(useCase: GitHubRepositoryUseCaseInput) {
        self.useCase = useCase
    }
    
    func searchRepository(keyword: String, perPage: Int, page: Int) async {
        await dataSouce.searchRepository(keyword: keyword, perPage: perPage, page: page)
    }
}

extension GitHubRepositoryGateway: GitHubRepositoryGatewayInput {
    func searchRepository(repositories: [GitHubAPIRepository]) {
        useCase?.searchRepository(repositories: repositories)
    }
}
