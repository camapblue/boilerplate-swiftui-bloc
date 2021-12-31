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
    
    // var blocs: [String: WeakRef] = [:]
    var blocs = NSMapTable<NSString, AnyObject>.init(
        keyOptions: .copyIn,
        valueOptions: .weakMemory
    )
    
    func newBloc<B: BaseBloc<E, S>, E: Event, S: State>(key: String,  constructor: @escaping () -> B) -> B {
        print("CURRENT BLOCS = \(blocs)")
        if let blocFound = blocs.object(forKey: key as NSString) as? B {
            print("BLOC FOUND = \(key)")
            return blocFound
        }
        
        print("NEW BLOC INSTANCE = \(key)")
        let newInstance = constructor()
//        let weakRef = WeakRef()
//        weakRef.ref = newInstance
        blocs.setObject(newInstance, forKey: key as NSString)
        
        return newInstance
    }
}
