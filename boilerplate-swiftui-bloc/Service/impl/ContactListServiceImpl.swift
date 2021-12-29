//
//  ContactListService.swift
//  boilerplate-swiftui-bloc
//
//  Created by @camapblue on 12/29/21.
//

import Foundation
import Combine
import Repository

class ContactListServiceImpl: LoadListService<Contact> {
    private var contactRepository: ContactRepository
    init(contactRepository: ContactRepository) {
        self.contactRepository = contactRepository
    }
    
    override func loadItems() throws -> Future<[Contact], Error> {
        return self.contactRepository.fetchContacts()
    }
}
