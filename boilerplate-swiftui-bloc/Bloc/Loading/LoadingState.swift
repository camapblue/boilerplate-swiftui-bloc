//
//  LoadingState.swift
//  boilerplate-swiftui-bloc
//
//  Created by @camapblue on 1/9/22.
//

import Foundation
import SwiftBloc

public class LoadingBloc: BaseBloc<LoadingEvent, LoadingState> {
    public init(key: String) {
        super.init(
            key: key,
            inititalState: LoadingInitial()
        )
        
        onEvent(LoadingShowed.self, handler: { event, emitter in
            emitter.send(LoadingUpdated(loading: true))
        })
        
        onEvent(LoadingHide.self, handler: { event, emitter in
            emitter.send(LoadingUpdated(loading: false))
        })
    }
}
