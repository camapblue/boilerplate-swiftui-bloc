//
//  LoadListState.swift
//  boilerplate-swiftui-bloc
//
//  Created by @camapblue on 12/29/21.
//

import Foundation

class LoadListState: State {
    var params: [String: AnyObject]?
    init(params: [String: AnyObject]? = nil) {
        self.params = params
    }
}

class LoadListLoadPageInitial: LoadListState { }

class LoadListLoadPageInProgress: LoadListState { }

class LoadListLoadPageSuccess<T: Equatable>: LoadListState {
    var items: [T]
    var nextPage: Int
    var isFinish: Bool
    
    init(items: [T], nextPage: Int, isFinish: Bool, params: [String: AnyObject]? = nil) {
        self.items = items
        self.nextPage = nextPage
        self.isFinish = isFinish
        super.init(params: params)
    }
    
    static func == (lhs: LoadListLoadPageSuccess, rhs: LoadListLoadPageSuccess) -> Bool {
        return lhs.items == rhs.items
            && lhs.nextPage == rhs.nextPage && lhs.isFinish == rhs.isFinish
    }
}

class LoadListLoadPageFailure: LoadListState { }

