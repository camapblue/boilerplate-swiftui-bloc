//
//  ContactState.swift
//  boilerplate-swiftui-bloc
//
//  Created by @camapblue on 12/31/21.
//

import Repository

public class ContactState: State {
    public var contact: Contact
    init(contact: Contact) {
        self.contact = contact
    }
}

public class ContactInitial: ContactState {}

public class ContactEditInProgress: ContactState {}

public class ContactEditSuccess: ContactState {}

public class ContactEditFailure: ContactState {}
