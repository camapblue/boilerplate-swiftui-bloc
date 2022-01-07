//
//  boilerplate_swiftui_blocApp.swift
//  boilerplate-swiftui-bloc
//
//  Created by @camapblue on 12/27/21.
//

import SwiftUI
import Repository

@main
struct boilerplate_swiftui_blocApp: App {
    let router = NavigationRouter(routes: .all)
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                RouterView(
                    router: router,
                    root: Configs.shared.isStorybook ? .storyBook : .splash
                )
            }
            .environment(\.router, router)
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}
