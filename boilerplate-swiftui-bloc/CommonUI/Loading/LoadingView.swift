//
//  LoadingView.swift
//  boilerplate-swiftui-bloc
//
//  Created by @camapblue on 12/29/21.
//

import SwiftUI

struct LoadingView: ViewModifier {
    func body(content: Content) -> some View {
        ZStack {
            ZStack(alignment: .center) {
                VStack {
                    Text("Loading...")
                    ProgressView()
                }
            }
        }
    }
}

extension View {
    @ViewBuilder
    func loadingOverlay(isLoading: Bool) -> some View {
        if isLoading {
            self.modifier(LoadingView())
        } else {
            self.modifier(EmptyModifier())
        }
    }
}
