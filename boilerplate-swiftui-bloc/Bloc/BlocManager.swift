//
//  BlocManager.swift
//  boilerplate-swiftui-bloc
//
//  Created by @camapblue on 12/29/21.
//

import Foundation
import SwiftBloc

typealias BlocConstructor = () -> BaseBloc<Event, State>

class BlocManager {
    static let shared = BlocManager()
    
    var blocs: [BaseBloc] = [BaseBloc<Event, State>]()
    
    func newBloc(key: String, constructor: BlocConstructor) -> BaseBloc<Event, State> {
        if let found = self.blocs.firstIndex(where: { $0.key == key }) {
          return blocs[found]
        }

        let newInstance = constructor()
    
        self.blocs.append(newInstance)
        
        return newInstance
    }
}
