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

class ContactInitial: ContactState {
    override init(contact: Contact) {
        super.init(contact: contact)
    }
}

class ContactEditInProgress: ContactState {
    override init(contact: Contact) {
        super.init(contact: contact)
    }
}

class ContactEditSuccess: ContactState {
    override init(contact: Contact) {
        super.init(contact: contact)
    }
}

class ContactEditFailure: ContactState {
    override init(contact: Contact) {
        super.init(contact: contact)
    }
}
