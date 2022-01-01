//
//  Bloc.swift
//  SwiftBloc
//
//  Created by Kachalov, Victor on 01.04.21.
//

import Combine

/**
 A state managing class with lower level of abstraction and unlike **Cubit** it depends on incoming events.
 */

/**
 Emitter
 - a PassthroughSubject which is capable of emitting new states.
 */
public typealias Emitter<S: Equatable> = PassthroughSubject<S, Never>

/**
 EventHandler
 - parameter event: the incoming event
 - parameter emitter: responsible for emit zero or more states when event is triggered
 */
public typealias EventHandler<E: Equatable, S: Equatable> = (_ event: E, _ emitter: Emitter<S>) -> Void

open class Bloc<Event, State>: Base<State> where State: Equatable, Event: Equatable {
    /**
     Whenever a new event happens, the instance of the **Bloc** wrapped in **ObservedObject**  in your **View** structure will receive
     a new value of event..
     */
    @Published internal(set) public var event: Event?
    
    /**
     Store a type of Event that has been added handler. Use to prevent multiple handler for an Event.
     */
    private var handledEvents = [Event.Type]()
    
    /**
     A collector for **AnyCancellable**
     */
    private var cancellables = Set<AnyCancellable>()
    /**
     Bloc constructor
     - parameter initialState: initial state.
     */
    public init(initialState: State) {
        super.init(state: initialState)
    }
    /**
     Deinitializer which will trigger observer callback **onClose** and remove all cancellables.
     */
    deinit {
        cancellables.forEach { $0.cancel() }
        observer.onClose(base: self)
    }
    /**
     Adds a new event.
     - parameter event: new event.
     */
    public func add(event: Event) {
        observer.onEvent(bloc: self, event: event)
        self.event = event
    }
    
    /**
     Add subscription to a concrete event. When ever a new event is added **emitter**  will be create and send to **handler** to add new state
     - parameter handler: function that include incoming event and emitter as parameter
     */
    public func onEvent<E: Equatable>(_ event: E.Type, handler: @escaping EventHandler<E, State>) {
        if(handledEvents.contains(where: { $0 == E.self })) {
            self.observer.onError(base: self, error: BlocError.eventHandlerHasBeenAdded)
            return
        }
        
        $event
            .filter({ $0 is Optional<E> })
            .sink(receiveValue: { [unowned self] event in
                guard let event = event else { return }
                
                let emitter = Emitter<State>()
                
                emitter.compactMap{ [unowned self] state in
                    Transition(
                        currentState: self.state,
                        event: event,
                        nextState: state)
                }.map { [unowned self] (transition) -> State in
                    if transition.nextState == self.state && self.emitted {
                        self.observer.onError(base: self, error: CubitError.stateNotChanged)
                        return self.state
                    }
                    self.observer.onTransition(bloc: self, transition: transition)
                    self.emitted = true
                    return transition.nextState
                }
                .sink(receiveValue: { [weak self] newState in
                    self?.state = newState
                })
                .store(in: &self.cancellables)
                
                handler(event as! E, emitter)
            })
            .store(in: &cancellables)
    }
}
