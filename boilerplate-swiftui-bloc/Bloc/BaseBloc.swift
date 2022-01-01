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
    private var closeWithBlocKey: String?
    var disposables: Set<AnyCancellable>
    var emitter: PassthroughSubject<S, Never>
    
    init(key: String, inititalState: S, closeWithBlocKey: String? = nil) {
        self.key = key
        self.closeWithBlocKey = closeWithBlocKey
        self.disposables = Set<AnyCancellable>()
        self.emitter = PassthroughSubject<S, Never>()
        emitter.send(inititalState)
        
        super.init(initialState: inititalState)
    }
}
