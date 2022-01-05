//
//  BlocTest.swift
//  SwiftBloc
//
//  Created by Kachalov, Victor on 01.04.21.
//

import Foundation
import Combine

public typealias BlocAction<S: Equatable, B: Base<S>> = ((B) -> Void)
public typealias BlocExpect<S: Equatable> = (() -> [S])
public typealias BlocVerifying = ((Bool, String) -> Void)

/**
 BlocTest
 */
final public class BlocTest<S: Equatable, B: Base<S>> {
    var bloc: B
    var cancellables = Set<AnyCancellable>()
    var states = [S]()
    
    public init(bloc: B) {
        self.bloc = bloc
        
        self.bloc.$state
            .sink(receiveValue: { [unowned self] value in
                self.states.append(value)
            })
            .store(in: &cancellables)
    }
    
    /// Executes event - state testing
    /// - Parameters:
    ///   - build: the **Bloc** object closure
    ///   - act: all potentially happening events should be described here
    ///   - wait: a delay before listening to state change
    ///   - expect: all expected states based on incoming events
    
    public func execute(
        act: BlocAction<S, B>?,
        wait: Int = 1,
        expect: @escaping BlocExpect<S>
    ) -> AnyPublisher<(Bool, [S]), Never> {
        act?(bloc)
        
        return Just(true)
            .delay(for: .seconds(wait), scheduler: RunLoop.main)
            .map { _ in
                let expected = expect()
                let areEqual = "\(self.states)" == "\(expected)"
                let message = "State received: \(self.states). \nStates expected: \(expected)"
                print(message)
                return (areEqual, self.states)
            }
            .eraseToAnyPublisher()
    }
}
