//
//  BlocProvider.swift
//  SwiftBloc
//
//  Created by Hao Tran Thien on 05/01/2022.
//

import Foundation
import SwiftUI

public typealias BlocProviderBuilder<V: View> = () -> V
public typealias BlocProviderCreate<B: Base<S>, S: Equatable> = () -> B

// MARK: BlocProviderView

public protocol BlocProviderProtocol: View {
    associatedtype S where S: Equatable
    associatedtype B where B: Base<S>
    associatedtype V where V: View
}

public struct BlocProvider<B: Base<S>, S: Equatable, V: View>: BlocProviderProtocol {
    private var bloc: B
    private var builder: BlocProviderBuilder<V>
    
    public init(@ViewBuilder builder: @escaping BlocProviderBuilder<V>, create: @escaping BlocProviderCreate<B, S>) {
        self.bloc = create()
        self.builder = builder
    }
    
    public var body: some View {
        builder().environmentObject(bloc)
    }
}

// MARK: ProvideBlocModifier

public protocol ProvideBlocModifierProtocol: ViewModifier {
    associatedtype S where S: Equatable
    associatedtype B where B: Base<S>
}

public struct ProvideBlocModifier<B: Base<S>, S: Equatable>: ProvideBlocModifierProtocol {
    let bloc: B
    
    public init(bloc: B) {
        self.bloc = bloc
    }
    
    public func body(content: Content) -> some View {
        content.environmentObject(bloc)
    }
}

public extension View {
    @ViewBuilder
    func provideBloc<B: Base<S>, S: Equatable>(create: @escaping BlocProviderCreate<B, S>) -> some View {
        let bloc = create()
        self.modifier(ProvideBlocModifier(bloc: bloc))
    }
}
