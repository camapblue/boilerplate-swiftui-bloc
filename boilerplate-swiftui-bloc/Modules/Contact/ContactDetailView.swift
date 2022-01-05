//
//  ContactDetailView.swift
//  boilerplate-swiftui-bloc
//
//  Created by @camapblue on 12/31/21.
//

import SwiftUI
import Repository
import SwiftBloc

struct ContactDetailView: View {
    @EnvironmentObject private var bloc: ContactBloc
    
    var body: some View {
        BlocView(builder: { (bloc) in
            let contact = bloc.state.contact
            
            ZStack {
                VStack {
                    Rectangle().fill(Color.clear).frame(height: 20)
                    AvatarView(avatar: contact.avatar, size: 128)
                    Rectangle().fill(Color.clear).frame(height: 44)
                    Text(contact.fullName())
                        .primaryRegular()
                    Rectangle().fill(Color.clear).frame(height: 44)
                    HStack(alignment: .firstTextBaseline) {
                        Text("address:")
                            .primaryRegular(fontSize: 15, color: .gray)
                            .frame(width: 100, alignment: .trailing)
                        Rectangle().fill(Color.clear).frame(width: 10, height: 20)
                        Text(contact.fullAddress())
                            .primaryRegular(fontSize: 17)
                        Spacer()
                    }
                    .frame(minWidth: 0, maxWidth: .infinity)
                    HStack {
                        Text("age:")
                            .primaryRegular(fontSize: 15, color: .gray)
                            .foregroundColor(.gray)
                            .frame(width: 100, alignment: .trailing)
                        Rectangle().fill(Color.clear).frame(width: 10, height: 20)
                        Text("\(contact.age())")
                            .primaryRegular(fontSize: 17)
                            .foregroundColor(.black)
                        Spacer()
                    }
                    .frame(minWidth: 0, maxWidth: .infinity)
                    Spacer()
                }
            }
            .navigationTitle(contact.firstName)
        }, base: self.bloc)
    }
}

struct ContactDetailView_Previews: PreviewProvider {
    static var contact = Contact.fakeContact()
    
    static var previews: some View {
        return BlocProvider {
            ContactDetailView()
        } create: {
            Blocs().contactBloc(contact: contact)
        }
        .frame(width: 375)
    }
}
