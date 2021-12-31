//
//  ContentView.swift
//  boilerplate-swiftui-bloc
//
//  Created by @camapblue on 12/27/21.
//

import SwiftUI
import Repository

struct SplashView: View {
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    Text("Splash View")
                    NavigationLink(
                        destination: LazyView(
                            ContactListView()
                        )
                    ) {
                        Text("Contact List")
                    }
                    .navigationTitle("Splash")
                }
                .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/, 0)
            }
        }
        .onAppear() {
            print("Splash Screen Appear")
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
