//
//  ContactListView.swift
//  boilerplate-swiftui-bloc
//
//  Created by @camapblue on 12/31/21.
//

import SwiftUI
import Repository

struct ContactListView: View {
    var body: some View {
        BlocProvider {
            LoadListView<Contact>() { contact in
                AnyView(
                    NavigationLink(
                        destination: LazyView(
                            ContactDetailView(contact: contact)
                        )
                    ) {
                        Text(contact.firstName)
                    }
                )
            } itemKey: { $0.id }
            .navigationTitle("Contacts")
        } create: {
            Blocs().contactListBloc()
        }
        .onAppear {
            print("Contact List appeared!")
        }.onDisappear {
            print("Contact List disappeared!")
        }
    }
}

struct ContactListView_Previews: PreviewProvider {
    static var previews: some View {
        ContactListView()
    }
}
