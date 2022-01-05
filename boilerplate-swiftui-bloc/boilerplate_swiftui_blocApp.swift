//
//  boilerplate_swiftui_blocApp.swift
//  boilerplate-swiftui-bloc
//
//  Created by @camapblue on 12/27/21.
//

import SwiftUI

@main
struct boilerplate_swiftui_blocApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                RouterView(
                    router: .main,
                    root: Configs.shared.isStorybook ? .storyBook : .splash
                )
            }
            .environment(\.router, .main)
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}

extension NavigationRouter {
  static var main = NavigationRouter(routes: .all)
}
