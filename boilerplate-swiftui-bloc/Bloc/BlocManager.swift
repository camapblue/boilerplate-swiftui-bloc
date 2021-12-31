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
    
    final class WeakRef {
        weak var ref: AnyObject?
    }
    
    var blocs: [String: WeakRef] = [:]
    
    func newBloc<B: BaseBloc<E, S>, E: Event, S: State>(key: String,  constructor: @escaping () -> B) -> B {
        if let blocFound = self.blocs.first(where: { $0.key == key })?.value.ref as? B {
            print("BLOC FOUND = \(key)")
            return blocFound
        }
        
        print("NEW BLOC INSTANCE = \(key)")
        let newInstance = constructor()
        let weakRef = WeakRef()
        weakRef.ref = newInstance
        self.blocs[key] = weakRef
        
        return newInstance
    }
}
