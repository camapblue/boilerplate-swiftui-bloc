//
//  AppShowing.swift
//  boilerplate-swiftui-bloc
//
//  Created by @camapblue on 1/9/22.
//

import SwiftUI
import SwiftBloc
import POC_Common_UI_iOS

struct AppShowing: View {
    @EnvironmentObject private var bloc: LoadingBloc
    let router = NavigationRouter(routes: .all)
    
    var body: some View {
        BlocView(builder: { bloc in
            NavigationView {
                RouterView(
                    router: router,
                    root: .splash
                )
            }
            .environment(\.router, router)
            .navigationViewStyle(StackNavigationViewStyle())
            .if(bloc.state.isLoading) { view in
                view.overlay(LoadingOverlay())
            }
        }, base: bloc)
    }
}

struct AppShowing_Previews: PreviewProvider {
    static var previews: some View {
        AppShowing()
    }
}
