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
    
    var blocs = NSMapTable<NSString, AnyObject>.init(
        keyOptions: .copyIn,
        valueOptions: .weakMemory
    )
    
    func newBloc<B: BaseBloc<E, S>, E: Event, S: State>(key: String,  constructor: @escaping () -> B) -> B {
        if let blocFound = blocs.object(forKey: key as NSString) as? B {
            return blocFound
        }
        
        let newInstance = constructor()
        blocs.setObject(newInstance, forKey: key as NSString)
        
        return newInstance
    }
}
