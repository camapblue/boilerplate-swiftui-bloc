//
//  LoadListView.swift
//  boilerplate-swiftui-bloc
//
//  Created by @camapblue on 12/29/21.
//

import SwiftUI
import SwiftBloc

typealias ItemBuilder<T: Equatable, V: View> = (_ item: T) -> V
typealias ItemKey<T: Equatable> = (_ item: T) -> String

struct ItemData<T: Equatable>: Identifiable {
    var id: String
    var data: T
    
    init(data: T, itemKey: @escaping ItemKey<T>) {
        self.id = itemKey(data)
        self.data = data
    }
}

struct LoadListView<T: Equatable, V: View>: View {
    @EnvironmentObject private var bloc: LoadListBloc<T>
    private var itemBuilder: ItemBuilder<T, V>
    private var itemKey: ItemKey<T>
    
    init(itemBuilder: @escaping ItemBuilder<T, V>, itemKey: @escaping ItemKey<T>) {
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
        }, action: { (bloc) in
            
        }, base: self.bloc)
    }
}
