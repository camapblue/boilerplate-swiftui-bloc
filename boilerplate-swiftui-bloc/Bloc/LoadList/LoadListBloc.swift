//
//  LoadListBloc.swift
//  boilerplate-swiftui-bloc
//
//  Created by @camapblue on 12/29/21.
//

import Combine
import SwiftUI

class LoadListBloc<T: Equatable>: BaseBloc<LoadListEvent, LoadListState> {
    private var loadListService: LoadListService<T>
    
    init(key: String, service: LoadListService<T>) {
        self.loadListService = service
        
        super.init(key: key, inititalState: LoadListLoadPageInitial())
    }
    
    override func mapEventToState(event: LoadListEvent) -> AnyPublisher<LoadListState, Never> {
        if event is LoadListStarted {
            mapEventStartedToState(event: event as! LoadListStarted)
        }
        return emitter.eraseToAnyPublisher()
    }
    
    private func mapEventStartedToState(event: LoadListStarted) {
        emitter.send(LoadListLoadPageInProgress())
        
        try! self.loadListService.loadItems(params: event.params)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(_):
                    self?.emitter.send(LoadListLoadPageFailure())
                }
            }, receiveValue: { [weak self] items in
                let nextState = LoadListLoadPageSuccess(items: items, nextPage: items.count, isFinish: true)
                self?.emitter.send(nextState)
            })
            .store(in: &self.disposables)
    }
}
