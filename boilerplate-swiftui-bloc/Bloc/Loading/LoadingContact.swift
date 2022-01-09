//
//  LoadingContact.swift
//  boilerplate-swiftui-bloc
//
//  Created by @camapblue on 1/9/22.
//

import Foundation

public class LoadingState: State {
    public let isLoading: Bool
    public init(_ loading: Bool) {
        self.isLoading = loading
    }
}

public class LoadingInitial: LoadingState {
    public init() { super.init(false) }
}

public class LoadingUpdated: LoadingState {
    public init(loading: Bool) {
        super.init(loading)
    }
}
