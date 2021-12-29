//
//  LoadListEvent.swift
//  boilerplate-swiftui-bloc
//
//  Created by @camapblue on 12/29/21.
//

import Foundation

class LoadListEvent: Event {
    var params: [String: AnyObject]?
    
    init(params: [String: AnyObject]? = nil) {
        self.params = params
    }
}

class LoadListStarted: LoadListEvent {}

class LoadListNextPage: LoadListEvent {}

class LoadListRefreshed: LoadListEvent {}

class LoadListReloaded: LoadListEvent {}
