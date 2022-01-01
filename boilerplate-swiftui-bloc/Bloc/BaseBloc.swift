//
//  BaseBloc.swift
//  boilerplate-swiftui-bloc
//
//  Created by @camapblue on 12/29/21.
//

import Foundation
import SwiftBloc
import Combine

class Event: Equatable {
    static func == (lhs: Event, rhs: Event) -> Bool {
        return false
    }
}

class State: Equatable {
    static func == (lhs: State, rhs: State) -> Bool {
        return false
    }
}

class BaseBloc<E: Equatable, S: Equatable>: Bloc<E, S> {
    var key: String
    var closeWithBlocKey: String?
    var disposables: Set<AnyCancellable>
    
    init(key: String, closeWithBlocKey: String? = nil, inititalState: S) {
        self.key = key
        self.closeWithBlocKey = closeWithBlocKey
        self.disposables = Set<AnyCancellable>()
        
        super.init(initialState: inititalState)
    }
    
    deinit {
        BlocManager.shared.disposeBloc(key: key)
    }
}
