//
//  GitHubRepositoryPresenter.swift
//  CleanArchitectureSample
//
//  Created by 岩本竜斗 on 2024/04/20.
//

import Foundation

protocol GitHubRepositoryPresenterProtocol {
    func searchRepository(keyword: String, perPage: Int, page: Int) async
}

protocol GitHubRepositoryPresenterInput: AnyObject {
    func searchRepository(repositories: [GitHubAPIRepository])
}

final class GitHubRepositoryPresenter: GitHubRepositoryPresenterProtocol, ObservableObject {
    @Published private(set) var repositories: [GitHubAPIRepository] = []
    private let useCase: GitHubRepositoryUseCase
    
    init(useCase: GitHubRepositoryUseCase) {
        self.useCase = useCase
    }
    
    func searchRepository(keyword: String, perPage: Int, page: Int) async {
        await useCase.searchRepository(keyword: keyword, perPage: perPage, page: page)
    }
}

extension GitHubRepositoryPresenter: GitHubRepositoryPresenterInput {
    func searchRepository(repositories: [GitHubAPIRepository]) {
        self.repositories = repositories
    }
}
