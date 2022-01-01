//
//  LoadListView.swift
//  boilerplate-swiftui-bloc
//
//  Created by @camapblue on 12/29/21.
//

import SwiftUI
import SwiftUIRefresh
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

class LoadListViewState: ObservableObject {
    @Published var isRefreshing = false
}

struct LoadListView<T: Equatable>: View {
    @EnvironmentObject private var bloc: LoadListBloc<T>
    private var itemBuilder: ItemBuilder<T>
    private var itemKey: ItemKey<T>
    private var autoStart: Bool
    private var pullToRefresh: Bool
    private var params: [String: AnyObject]?
    
    @StateObject var viewState = LoadListViewState()
    
    init(params: [String: AnyObject]? = nil,
         autoStart: Bool = true,
         pullToRefresh: Bool = false,
         itemBuilder: @escaping ItemBuilder<T>,
         itemKey: @escaping ItemKey<T>) {
        self.params = params
        self.itemBuilder = itemBuilder
        self.itemKey = itemKey
        self.autoStart = autoStart
        self.pullToRefresh = pullToRefresh
    }
    
    var body: some View {
        BlocView(builder: { (bloc) in
            let isLoading = (bloc.state is LoadListLoadPageInProgress
                || bloc.state is LoadListLoadPageInitial && !viewState.isRefreshing)
            let items = (bloc.state as? LoadListLoadPageSuccess<T>)?.items
                .map { ItemData(data: $0, itemKey: itemKey) }
            
            ZStack {
                VStack {
                    if pullToRefresh {
                        List(items ?? [], id: \.id) { item in
                            itemBuilder(item.data)
                        }
                        .pullToRefresh(isShowing: $viewState.isRefreshing) {
                            bloc.add(event: LoadListRefreshed(params: params))
                        }
                    } else {
                        List(items ?? [], id: \.id) { item in
                            itemBuilder(item.data)
                        }
                    }
                    Spacer()
                }
                .loadingOverlay(isLoading: isLoading)
                .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/, 0)
            }
        }, action: { bloc in
            if bloc.state is LoadListLoadPageSuccess<T> && viewState.isRefreshing {
                self.viewState.isRefreshing = false
            }
        }, base: self.bloc)
        .onAppear {
            if autoStart {
                self.bloc.add(event: LoadListStarted(params: params))
            }
        }
    }
}
