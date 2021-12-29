//
//  LoadListBloc.swift
//  boilerplate-swiftui-bloc
//
//  Created by @camapblue on 12/29/21.
//

import Combine

class LoadListBloc<T: Equatable>: BaseBloc<LoadListEvent, LoadListState> {
    private var loadListService: LoadListService<T>
    
    init(key: String, service: LoadListService<T>) {
        self.loadListService = service
        
        super.init(key: key, inititalState: LoadListLoadPageInitial())
    }
    
    override func mapEventToState(event: LoadListEvent) -> AnyPublisher<LoadListState, Never> {
        if event is LoadListStarted {
            return mapEventStartedToState(event: event as! LoadListStarted)
        }
        return Just(LoadListLoadPageFailure()).eraseToAnyPublisher()
    }
    
    func mapEventStartedToState(event: LoadListStarted) -> AnyPublisher<LoadListState, Never> {
        return Future { [unowned self] promise in
            promise(.success(LoadListLoadPageInProgress()))
            
            try! self.loadListService.loadItems(params: event.params)
                .sink(receiveCompletion: { error in
                    promise(.success(LoadListLoadPageFailure()))
                }, receiveValue: { items in
                    let nextState = LoadListLoadPageSuccess(items: items, nextPage: items.count, isFinish: true)
                    promise(.success(nextState))
                })
                .store(in: &self.disposables)
        }.eraseToAnyPublisher()
    }
}
