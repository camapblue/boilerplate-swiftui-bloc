//
//  Blocs.swift
//  boilerplate-swiftui-bloc
//
//  Created by @camapblue on 12/29/21.
//

import Foundation
import Repository

class Blocs {
    
    // Load List
    func contactListBloc() -> LoadListBloc<Contact> {
        let key = Keys.Bloc.contactList
        let bloc = BlocManager.shared.newBloc(LoadListBloc<Contact>.self, key: key) {
            return LoadListBloc<Contact>(
                key: key,
                service: Services().contactListService()
            )
        }
        return bloc
    }
}
