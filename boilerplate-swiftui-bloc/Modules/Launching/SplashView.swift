//
//  ContentView.swift
//  boilerplate-swiftui-bloc
//
//  Created by @camapblue on 12/27/21.
//

import SwiftUI
import Repository

struct SplashView: View {
    @EnvironmentObject private var contactListBloc: LoadListBloc<Contact>
    
    var body: some View {
        NavigationView {
            LoadListView<Contact, Text>() { contact in
                Text(contact.firstName)
            } itemKey: { $0.id }
        }.onAppear {
            contactListBloc.add(event: LoadListStarted())
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        BlocProvider {
            SplashView()
        } create: {
            Blocs().contactListBloc()
        }
    }
}
