//
//  Services.swift
//  boilerplate-swiftui-bloc
//
//  Created by @camapblue on 12/29/21.
//

import Foundation
import Repository

// Dependency Injection for Services layer
class Services {
    func contactService() -> ContactService {
        return ContactServiceImpl(contactRepository: Repository.shared.contactRepository())
    }
    
    // list service
    func contactListService() -> LoadListService<Contact> {
        return ContactListServiceImpl(contactRepository: Repository.shared.contactRepository())
    }
}
