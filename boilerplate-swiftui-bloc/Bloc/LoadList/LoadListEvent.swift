//
//  LoadListEvent.swift
//  boilerplate-swiftui-bloc
//
//  Created by @camapblue on 12/29/21.
//

import Foundation

class LoadListEvent: Event {
    var params: [String: Any]?
    
    init(params: [String: Any]? = nil) {
        self.params = params
    }
}

class LoadListStarted: LoadListEvent {}

class LoadListNextPage: LoadListEvent {}

class LoadListRefreshed: LoadListEvent {}

class LoadListReloaded<T: Equatable>: LoadListEvent {
    var items: [T]?
    init(items: [T]? = nil) {
        self.items = items
    }
}
