//
//  BlocManager.swift
//  boilerplate-swiftui-bloc
//
//  Created by @camapblue on 12/29/21.
//

import Foundation
import SwiftBloc

class BlocManager {
    static let shared = BlocManager()
    
    var blocs: [String: [Any]] = [:]
    
    func newBloc<B: BaseBloc<E, S>, E: Event, S: State>(_ type: B.Type, key: String,  constructor: @escaping () -> B) -> B {
        if var blocsFound = self.blocs.first(where: { $0.key == "\(B.self)" })?.value {
            if let found = blocsFound.first(where: { ($0 as! B).key == key }) as? B {
                return found
            }
            let newInstance = constructor()
            blocsFound.append(newInstance)
            return newInstance
        }
        
        let newInstance = constructor()
        
        self.blocs["\(B.self)"] = [newInstance]
        
        return newInstance
    }
}
