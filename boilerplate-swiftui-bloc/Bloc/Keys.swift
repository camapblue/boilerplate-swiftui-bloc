//
//  Keys.swift
//  boilerplate-swiftui-bloc
//
//  Created by @camapblue on 12/29/21.
//

import Foundation

class Keys {
    
    class Bloc {
        // common
        static let loadingBloc = "loading_bloc_key"
        
        // list
        static let contactList = "contact_list_bloc_key"
        
        // single with key
        static func contactBlocById(id: String) -> String {
            return "contact_bloc_key_\(id)"
        }
    }
}
