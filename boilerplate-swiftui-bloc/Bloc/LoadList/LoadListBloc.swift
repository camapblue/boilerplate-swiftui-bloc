//
//  LoadListBloc.swift
//  boilerplate-swiftui-bloc
//
//  Created by @camapblue on 12/29/21.
//

import Combine
import SwiftUI
import SwiftBloc

class LoadListBloc<T: Equatable>: BaseBloc<LoadListEvent, LoadListState> {
    private var loadListService: LoadListService<T>
    
    init(key: String, service: LoadListService<T>) {
        self.loadListService = service
        super.init(key: key, inititalState: LoadListLoadPageInitial())
        self.onEvent(LoadListStarted.self, handler: { [weak self] event, emitter in
            self?.onLoadListStartedEvent(event: event, emitter: emitter)
        })
    }
    
    private func onLoadListStartedEvent(event: LoadListStarted, emitter: Emitter<LoadListState>) {
        emitter.send(LoadListLoadPageInProgress())
        
        try! self.loadListService.loadItems(params: event.params)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(_):
                    emitter.send(LoadListLoadPageFailure())
                }
            }, receiveValue: { items in
                let nextState = LoadListLoadPageSuccess(items: items, nextPage: items.count, isFinish: true)
                emitter.send(nextState)
            })
            .store(in: &self.disposables)
    }
}
