//
//  ContactState.swift
//  boilerplate-swiftui-bloc
//
//  Created by @camapblue on 12/31/21.
//

import Repository

class ContactState: State {
    var contact: Contact
    init(contact: Contact) {
        self.contact = contact
    }
}

class ContactInitial: ContactState {}

class ContactEditInProgress: ContactState {}

class ContactEditSuccess: ContactState {}

class ContactEditFailure: ContactState {}
