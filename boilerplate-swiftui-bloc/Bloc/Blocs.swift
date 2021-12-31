//
//  Blocs.swift
//  boilerplate-swiftui-bloc
//
//  Created by @camapblue on 12/29/21.
//

import Foundation
import Repository

class Blocs {
    
    // Single
    func contactBloc(contact: Contact) -> ContactBloc {
        let key = Keys.Bloc.contactBlocById(id: contact.id)
        return BlocManager.shared.newBloc(key: key) {
            return ContactBloc(
                key: key,
                contact: contact,
                service: Services().contactService()
            )
        } as! ContactBloc
    }
    
    // Load List
    func contactListBloc() -> LoadListBloc<Contact> {
        let key = Keys.Bloc.contactList
        let bloc = BlocManager.shared.newBloc(key: key) {
            return LoadListBloc<Contact>(
                key: key,
                service: Services().contactListService()
            )
        }
        return bloc as! LoadListBloc<Contact>
    }
}
