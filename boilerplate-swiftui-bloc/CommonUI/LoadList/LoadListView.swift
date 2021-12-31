//
//  LoadListView.swift
//  boilerplate-swiftui-bloc
//
//  Created by @camapblue on 12/29/21.
//

import SwiftUI
import SwiftBloc

typealias ItemBuilder<T: Equatable> = (_ item: T) -> AnyView
typealias ItemKey<T: Equatable> = (_ item: T) -> String

struct ItemData<T: Equatable>: Identifiable {
    var id: String
    var data: T
    
    init(data: T, itemKey: @escaping ItemKey<T>) {
        self.id = itemKey(data)
        self.data = data
    }
}

struct LoadListView<T: Equatable>: View {
    private var bloc: LoadListBloc<T>
    private var itemBuilder: ItemBuilder<T>
    private var itemKey: ItemKey<T>
    
    init(bloc: LoadListBloc<T>, itemBuilder: @escaping ItemBuilder<T>, itemKey: @escaping ItemKey<T>) {
        self.bloc = bloc
        self.itemBuilder = itemBuilder
        self.itemKey = itemKey
    }
    
    var body: some View {
        BlocView(builder: { (bloc) in
            let isLoading = bloc.state is LoadListLoadPageInProgress
                || bloc.state is LoadListLoadPageInitial
            let items = (bloc.state as? LoadListLoadPageSuccess<T>)?.items
                .map { ItemData(data: $0, itemKey: itemKey) }
            
            ZStack {
                VStack {
                    List(items ?? [], id: \.id) { item in
                        itemBuilder(item.data)
                    }
                    Spacer()
                }
                .loadingOverlay(isLoading: isLoading)
                .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/, 0)
            }
        }, base: self.bloc)
    }
}
