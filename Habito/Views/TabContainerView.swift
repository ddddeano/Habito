//
//  TabContainerView.swift
//  Habito
//
//  Created by Daniel Watson on 21/01/2021.
//

import SwiftUI

struct TabContainerView: View {
    
    @StateObject private var tabContainerViewModel = TabContainerViewModel()
    
    var body: some View {
        TabView(selection: $tabContainerViewModel.selectedTab) {
            ForEach(tabContainerViewModel.tabItemViewModels, id: \.self) { viewModel in
                tabView(for: viewModel.type)
                    .tabItem {
                        Image(systemName: viewModel.imageName)
                        Text(viewModel.title)
                    }
                    .tag(viewModel.type)
            }
        }.accentColor(.primary)
    }
    @ViewBuilder
    func tabView(for tabItemType: TabItemViewModel.TabItemType) -> some View {
        switch tabItemType {
        case .log:
            Text("Log")
        case .challengeList:
            Text("Challenge List")
        case .settings:
            Text("Settings")
        }
    }
}

final class TabContainerViewModel: ObservableObject {
    @Published var selectedTab: TabItemViewModel.TabItemType = .challengeList
    
    let tabItemViewModels = [
        TabItemViewModel(imageName: "book", title: "Activity Log", type: .log),
        .init(imageName: "list.bullet", title: "challenges", type: .challengeList),
        .init(imageName: "gear", title: "Setttings", type: .settings)
    ]
}

struct TabItemViewModel: Hashable{
    var imageName: String
    var title: String
    let type: TabItemType
    
    enum TabItemType {
        case log
        case challengeList
        case settings
    }
}
