//
//  LoadListState.swift
//  boilerplate-swiftui-bloc
//
//  Created by @camapblue on 12/29/21.
//

import Foundation

class LoadListState<T: Equatable>: State {
    var params: [String: Any]?
    var items: [T]
    
    init(params: [String: Any]? = nil, items: [T] = [T]()) {
        self.params = params
        self.items = items
    }
}

class LoadListLoadPageInitial<T: Equatable>: LoadListState<T> { }

class LoadListLoadPageInProgress<T: Equatable>: LoadListState<T> {
    init(items: [T] = [T]()) {
        super.init(items: items)
    }
}

class LoadListLoadPageSuccess<T: Equatable>: LoadListState<T> {
    var nextPage: Int
    var isFinished: Bool
    
    init(items: [T], nextPage: Int, isFinished: Bool, params: [String: Any]? = nil) {
        self.nextPage = nextPage
        self.isFinished = isFinished
        
        super.init(params: params, items: items)
    }
    
    static func == (lhs: LoadListLoadPageSuccess, rhs: LoadListLoadPageSuccess) -> Bool {
        return lhs.items == rhs.items
            && lhs.nextPage == rhs.nextPage && lhs.isFinished == rhs.isFinished
    }
}

class LoadListLoadPageFailure<T: Equatable>: LoadListState<T> { }

