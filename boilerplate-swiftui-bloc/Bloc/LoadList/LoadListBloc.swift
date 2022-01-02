//
//  LoadListBloc.swift
//  boilerplate-swiftui-bloc
//
//  Created by @camapblue on 12/29/21.
//

import Combine
import SwiftUI
import SwiftBloc

class LoadListBloc<T: Equatable>: BaseBloc<LoadListEvent, LoadListState<T>> {
    private var loadListService: LoadListService<T>
    
    init(key: String, service: LoadListService<T>) {
        self.loadListService = service
        super.init(key: key, inititalState: LoadListLoadPageInitial())
        
        self.onEvent(LoadListStarted.self, handler: { [weak self] event, emitter in
            self?.onLoadListLoadedPageEvent(event: event, emitter: emitter)
        })
        
        self.onEvent(LoadListNextPage.self, handler: { [weak self] event, emitter in
            self?.onLoadListLoadedPageEvent(event: event, emitter: emitter)
        })
        
        self.onEvent(LoadListReloaded<T>.self, handler: { [weak self] event, emitter in
            if let allItems = event.items {
                let nextState = LoadListLoadPageSuccess(
                    items: allItems, nextPage: allItems.count, isFinished: allItems.isEmpty)
                emitter.send(nextState)
            } else {
                self?.loadListService.forceToRefresh()
                self?.onLoadListLoadedPageEvent(event: LoadListStarted(params: event.params), emitter: emitter)
            }
        })
        
        self.onEvent(LoadListRefreshed.self, handler: { [weak self] event, emitter in
            self?.loadListService.forceToRefresh()
            self?.onLoadListLoadedPageEvent(event: LoadListStarted(params: event.params), emitter: emitter)
        })
    }
    
    private func onLoadListLoadedPageEvent(event: LoadListEvent, emitter: Emitter<LoadListState<T>>) {
        var params = event.params ?? [String: Any]()
        var allItems = [T]()
        if event is LoadListStarted {
            params["index"] = 0
            emitter.send(LoadListLoadPageInProgress())
        } else if event is LoadListNextPage, let currentState = state as? LoadListLoadPageSuccess<T> {
            params["index"] = currentState.nextPage
            allItems = currentState.items
            emitter.send(LoadListLoadPageInProgress(items: allItems))
        }
        
        try! self.loadListService.loadItems(params: params)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(_):
                    emitter.send(LoadListLoadPageFailure())
                }
            }, receiveValue: { items in
                let uniquedItems = items.removingDuplicates()
                allItems = allItems + uniquedItems
                let nextState = LoadListLoadPageSuccess(
                    items: allItems, nextPage: allItems.count, isFinished: uniquedItems.isEmpty)
                emitter.send(nextState)
            })
            .store(in: &self.disposables)
    }
}
