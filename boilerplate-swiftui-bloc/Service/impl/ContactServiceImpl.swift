//
//  ContactServiceImpl.swift
//  boilerplate-swiftui-bloc
//
//  Created by @camapblue on 12/28/21.
//

import Foundation
import Combine
import Repository

class ContactServiceImpl: ContactService {
    private var contactRepository: ContactRepository!
    
    init(contactRepository: ContactRepository) {
        self.contactRepository = contactRepository
    }
    
    func getCachedContacts() -> Future<[Contact], Error> {
        return self.contactRepository.fetchContacts()
    }
}
