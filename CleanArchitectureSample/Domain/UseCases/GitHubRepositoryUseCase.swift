//
//  GitHubRepositoryUseCase.swift
//  CleanArchitectureSample
//
//  Created by 岩本竜斗 on 2024/04/20.
//

import Foundation

protocol GitHubRepositoryUseCase {
    func searchRepository(keyword: String, perPage: Int, page: Int) async
}

protocol GitHubRepositoryUseCaseInput: AnyObject {
    func searchRepository(repositories: [GitHubAPIRepository])
}

final class GitHubRepositoryInteractor: GitHubRepositoryUseCase {
    private weak var presenter: GitHubRepositoryPresenterInput?
    private let gateway: GitHubRepositoryGatewayProtocol
    
    init(gateway: GitHubRepositoryGatewayProtocol) {
        self.gateway = gateway
    }
    
    func inject(presenter: GitHubRepositoryPresenterInput) {
        self.presenter = presenter
    }
    
    func searchRepository(keyword: String, perPage: Int, page: Int) async {
        await gateway.searchRepository(keyword: keyword, perPage: perPage, page: page)
    }
}

extension GitHubRepositoryInteractor: GitHubRepositoryUseCaseInput {
    func searchRepository(repositories: [GitHubAPIRepository]) {
        presenter?.searchRepository(repositories: repositories)
    }
}
