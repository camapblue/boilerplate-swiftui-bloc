//
//  ContentView.swift
//  boilerplate-swiftui-bloc
//
//  Created by @camapblue on 12/27/21.
//

import SwiftUI
import Repository

struct SplashView: View {
    private var contactListBloc: LoadListBloc<Contact>
    
    init(contactListBloc: LoadListBloc<Contact>) {
        self.contactListBloc = contactListBloc
        contactListBloc.add(event: LoadListStarted())
    }
    
    var body: some View {
        NavigationView {
            LoadListView<Contact, Text>(bloc: contactListBloc) { contact in
                Text(contact.firstName)
            } itemKey: { $0.id }

        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView(contactListBloc: Blocs().contactListBloc())
    }
}
