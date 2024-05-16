//
//  RepositoryListView.swift
//  CleanArchitectureSample
//
//  Created by 岩本竜斗 on 2024/04/20.
//

import SwiftUI

struct RepositoryListView: View {
    @ObservedObject private var presenter: GitHubRepositoryPresenter
    @State private var text: String = ""
    
    init(presenter: GitHubRepositoryPresenter) {
        self._presenter = .init(initialValue: presenter)
    }
    
    var body: some View {
        VStack {
            TextField("", text: $text)
                .padding()
                .textFieldStyle(.roundedBorder)
                .onSubmit {
                    Task {
                        await presenter.searchRepository(keyword: text, perPage: 20, page: 1)
                    }
                }
            List {
                ForEach(presenter.repositories) { repository in
                    Text(repository.fullName)
                }
            }
        }
    }
}

//#Preview {
//    RepositoryListView()
//}
