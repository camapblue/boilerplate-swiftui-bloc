//
//  ContactEvent.swift
//  boilerplate-swiftui-bloc
//
//  Created by @camapblue on 12/31/21.
//

import Repository

public class ContactEvent: Event {}

public class ContactEdited: ContactEvent {
    var contact: Contact
    public init(contact: Contact) {
        self.contact = contact
    }
}

