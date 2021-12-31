//
//  BlocProvider.swift
//  boilerplate-swiftui-bloc
//
//  Created by Hao Tran Thien on 31/12/2021.
//

import Foundation
import SwiftUI


typealias BlocProviderBuilder<V: View> = () -> V
typealias BlocProviderCreate<B: BaseBloc<E, S>, E: Event, S: State> = () -> B

protocol BlocProviderProtocol: View {
    associatedtype S where S: State
    associatedtype E where E: Event
    associatedtype B where B: BaseBloc<E, S>
    associatedtype V where V: View
}

struct BlocProvider<B: BaseBloc<E, S>, E: Event, S: State, V: View>: BlocProviderProtocol {
    private var bloc: B
    private var builder: BlocProviderBuilder<V>
    
    init(@ViewBuilder builder: @escaping BlocProviderBuilder<V>, create: @escaping BlocProviderCreate<B, E, S>) {
        self.bloc = create()
        self.builder = builder
    }
    
    var body: some View {
        builder().environmentObject(bloc)
    }
}
