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
    @SwiftUI.State private var editingFullName: String = ""
    
    var body: some View {
        BlocView(builder: { (bloc) in
            let contact = bloc.state.contact
            
            ZStack {
                VStack {
                    Rectangle().fill(Color.clear).frame(height: 20)
                    AvatarView(avatar: contact.avatar, size: 128)
                    Rectangle().fill(Color.clear).frame(height: 44)
                    HStack {
                        SpacerView(width: 64)
                        if editingFullName.isEmpty {
                            Text(contact.fullName())
                                .primaryBold(fontSize: 20)
                        } else {
                            TextField("Input name", text: $editingFullName)
                                .padding()
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .strokeBorder(Color.black, style: StrokeStyle(lineWidth: 1.0))
                                )
                                .padding()
                        }
                        SpacerView(width: 32)
                        if editingFullName.isEmpty {
                            Button(action: {
                                editingFullName = contact.fullName()
                            }) {
                                Image("ico_edit")
                                    .renderingMode(.original)
                            }
                        } else {
                            SpacerView(width: 32)
                        }
                    }
                    .frame(height: 44)
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
                    ButtonView.primary("Primary Button", disabled: editingFullName == contact.fullName() || editingFullName.isEmpty) {
                        let blocKey = Keys.Bloc.contactBlocById(id: contact.id)
                        print("BLOC KEY = \(blocKey)")
                        BlocManager.shared.event(
                            ContactBloc.self,
                            key: blocKey,
                            event: ContactEdited(contact: contact)
                        )
                    }
                    .padding(.horizontal, 32)
                    SpacerView(height: 32)
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
