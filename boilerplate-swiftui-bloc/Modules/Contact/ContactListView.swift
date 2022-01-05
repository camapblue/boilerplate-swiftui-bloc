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
    @Environment(\.router) var router
    
    var body: some View {
        LoadListView<Contact>(pullToRefresh: true, isLoadMore: false) { contact in
            return AnyView(
                Button(action: {
                    router.push(link: .contactDetails(with: contact.id))
                }, label: {
                    ContactRowItem()
                        .provideBloc(create: { Blocs().contactBloc(contact: contact) })
                })
            )
        } itemKey: {
            return $0.id
        }
        .navigationTitle("Contacts")
    }
}

struct ContactRowItem: View {
    @EnvironmentObject var contactBloc: ContactBloc
    
    var body: some View {
        BlocView(builder: { (bloc) in
            let contact = bloc.state.contact
            HStack(alignment: .center) {
                AvatarView(avatar: contact.avatar, size: 32)
                VStack(alignment: .leading) {
                    Text(contact.fullName())
                        .primaryBold(fontSize: 15)
                    Text("age: \(contact.age())")
                        .secondaryRegular(color: .gray)
                }
                .foregroundColor(.black)
                Spacer()
            }
            .frame(minHeight: 44, maxHeight: 44, alignment: .center)
        }, base: contactBloc)
    }
}

struct ContactListView_Previews: PreviewProvider {
    static var previews: some View {
        ContactListView()
    }
}
