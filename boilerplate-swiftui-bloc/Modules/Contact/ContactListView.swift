//
//  ContactListView.swift
//  boilerplate-swiftui-bloc
//
//  Created by @camapblue on 12/31/21.
//

import SwiftUI
import SwiftBloc
import Repository

struct ContactListView: View {
    var body: some View {
        BlocProvider {
            LoadListView<Contact>(pullToRefresh: true, isLoadMore: false) { contact in
                let bloc = Blocs().contactBloc(contact: contact)
                return AnyView(
                    BlocProvider {
                        NavigationLink(
                            destination: LazyView(
                                ContactDetailView()
                                    .environmentObject(bloc)
                            )
                        ) {
                            ContactRowItem(contactId: contact.id)
                        }
                    } create: {
                        bloc
                    }
                )
            } itemKey: {
                return $0.id
            }
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

struct ContactRowItem: View {
    var contactId: String
    
    var body: some View {
        if let contactBloc = BlocManager.shared.blocByKey(key: Keys.Bloc.contactBlocById(id: contactId)) as? ContactBloc {
            BlocView(builder: { (bloc) in
                let contact = bloc.state.contact
                HStack(alignment: .center) {
                    AvatarView(avatar: contact.avatar, size: 32)
                    VStack(alignment: .leading) {
                        Text(contact.fullName())
                        Text("age: \(contact.age())")
                    }
                    Spacer()
                }
                .frame(minHeight: 44, maxHeight: 44, alignment: .center)
            }, base: contactBloc)
        } else {
            Text("Bloc is Missing")
        }
    }
}

struct ContactListView_Previews: PreviewProvider {
    static var previews: some View {
        ContactListView()
    }
}
