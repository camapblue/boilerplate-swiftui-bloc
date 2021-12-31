//
//  ContactListView.swift
//  boilerplate-swiftui-bloc
//
//  Created by @camapblue on 12/31/21.
//

import SwiftUI
import Repository

struct ContactListView: View {
    private var contactListBloc: LoadListBloc<Contact>
    
    init() {
        print("CONTACT LIST INIT")
        self.contactListBloc = Blocs().contactListBloc()
    }
    
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
                    .navigationTitle(contact.firstName)
                )
            } itemKey: { $0.id }
        } create: {
            self.contactListBloc 
        }
       
        .onAppear {
            print("Contact List appeared!")
            contactListBloc.add(event: LoadListStarted())
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
