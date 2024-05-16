//
//  CleanArchitectureSampleApp.swift
//  CleanArchitectureSample
//
//  Created by 岩本竜斗 on 2024/04/20.
//

import SwiftUI

@main
struct CleanArchitectureSampleApp: App {
    var body: some Scene {
        WindowGroup {
            GitHubRepositoryBuilder.build()
        }
    }
}

struct GitHubRepositoryBuilder {
    static func build() -> some View {
        let dataSouce = GitHubAPIClient()
        let gateway = GitHubRepositoryGateway(dataSouce: dataSouce)
        let useCase = GitHubRepositoryInteractor(gateway: gateway)
        let presenter = GitHubRepositoryPresenter(useCase: useCase)
        
        dataSouce.inject(gateway: gateway)
        gateway.inject(useCase: useCase)
        useCase.inject(presenter: presenter)
        
        return RepositoryListView(presenter: presenter)
    }
}
