//
//  ContactDetailView.swift
//  boilerplate-swiftui-bloc
//
//  Created by @camapblue on 12/31/21.
//

import SwiftUI
import Repository
import SwiftBloc

class ContactDetailViewModel {
    init() {
        print("Contact Detail VM init")
    }
    
    deinit {
        print("Contact Detail VM deinit")
    }
}

struct ContactDetailView: View {
    var contact: Contact
    var viewMode = ContactDetailViewModel()
    
    init(contact: Contact) {
        print("CONTACT DETAIL INIT")
        self.contact = contact
    }
    
    var body: some View {
        BlocView(builder: { (bloc) in
            let contact = bloc.state.contact
            
            ZStack {
                VStack {
                    Rectangle().fill(Color.clear).frame(height: 20)
                    AvatarView(avatar: contact.avatar, size: 128)
                    Rectangle().fill(Color.clear).frame(height: 44)
                    Text(contact.fullName())
                        .font(.custom("Helvetica", size: 24))
                        .fontWeight(.bold)
                        .foregroundColor(Color.black)
                    Rectangle().fill(Color.clear).frame(height: 44)
                    HStack(alignment: .firstTextBaseline) {
                        Text("address:")
                            .font(.custom("Helvetica", size: 15))
                            .foregroundColor(.gray)
                            .frame(width: 100, alignment: .trailing)
                        Rectangle().fill(Color.clear).frame(width: 10, height: 20)
                        Text(contact.fullAddress())
                            .font(.custom("Helvetica", size: 17))
                            .foregroundColor(.black)
                        Spacer()
                    }
                    .frame(minWidth: 0, maxWidth: .infinity)
                    HStack {
                        Text("age:")
                            .font(.custom("Helvetica", size: 15))
                            .foregroundColor(.gray)
                            .frame(width: 100, alignment: .trailing)
                        Rectangle().fill(Color.clear).frame(width: 10, height: 20)
                        Text("\(contact.age())")
                            .font(.custom("Helvetica", size: 17))
                            .foregroundColor(.black)
                        Spacer()
                    }
                    .frame(minWidth: 0, maxWidth: .infinity)
                    Spacer()
                }
            }
            .navigationTitle(contact.firstName)
        }, base: Blocs().contactBloc(contact: contact))
        .onAppear {
            print("Contact Detail appeared!")
        }.onDisappear {
            print("Contact Detail disappeared!")
        }
    }
}

struct ContactDetailView_Previews: PreviewProvider {
    static var contact = Contact.fakeContact()
    
    static var previews: some View {
        print("PREVIEWS NOW")
        return ContactDetailView(contact: contact)
            .frame(width: 375)
    }
}
