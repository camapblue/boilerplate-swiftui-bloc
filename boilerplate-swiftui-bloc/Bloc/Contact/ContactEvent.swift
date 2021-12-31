//
//  ContactEvent.swift
//  boilerplate-swiftui-bloc
//
//  Created by @camapblue on 12/31/21.
//

import Repository

class ContactEvent: Event {}

class ContactEdited: ContactEvent {
    var contact: Contact
    init(contact: Contact) {
        self.contact = contact
    }
}

