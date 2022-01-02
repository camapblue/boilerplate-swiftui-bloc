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
typealias ItemFilter<T: Equatable> = (_ item: T) -> Bool
typealias ItemSort<T: Equatable> = (_ item1: T, _ item2: T) -> Bool

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
    private var itemFilter: ItemFilter<T>?
    private var itemSort: ItemSort<T>?
    private var itemKey: ItemKey<T>
    private var autoStart: Bool
    private var pullToRefresh: Bool
    private var isLoadMore: Bool
    private var params: [String: Any]?
    
    @StateObject var viewState = LoadListViewState()
    
    init(params: [String: Any]? = nil,
         autoStart: Bool = true,
         pullToRefresh: Bool = false,
         isLoadMore: Bool = true,
         itemBuilder: @escaping ItemBuilder<T>,
         itemFilter: ItemFilter<T>? = nil,
         itemSort: ItemSort<T>? = nil,
         itemKey: @escaping ItemKey<T>) {
        self.params = params
        self.itemBuilder = itemBuilder
        self.itemFilter = itemFilter
        self.itemSort = itemSort
        self.itemKey = itemKey
        self.autoStart = autoStart
        self.pullToRefresh = pullToRefresh
        self.isLoadMore = isLoadMore
    }
    
    var body: some View {
        BlocView(builder: { (bloc) in
            let items = bloc.state.items
                .filter { item in
                    if let filter = itemFilter {
                        return filter(item)
                    }
                    return true
                }
            let isLoading = (bloc.state is LoadListLoadPageInProgress
                                || bloc.state is LoadListLoadPageInitial) && !viewState.isRefreshing && items.isEmpty
            
            let sortedItems = itemSort == nil ? items : items.sorted(by: { itemSort!($0, $1) })
            let final = sortedItems.map { ItemData(data: $0, itemKey: itemKey) }
            let isFinished = (bloc.state as? LoadListLoadPageSuccess<T>)?.isFinished ?? true
                        
            ZStack {
                VStack {
                    if pullToRefresh {
                        List {
                            ForEach(final, id: \.id) { item in
                                itemBuilder(item.data)
                            }
                            if !isFinished && isLoadMore {
                                HStack {
                                    ProgressView()
                                }
                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 44, maxHeight: 44, alignment: .center)
                                .onAppear(perform: loadMore)
                            }
                        }
                        .pullToRefresh(isShowing: $viewState.isRefreshing) {
                            bloc.add(event: LoadListRefreshed(params: params))
                        }
                    } else {
                        List {
                            ForEach(final, id: \.id) { item in
                                itemBuilder(item.data)
                            }
                            if !isFinished && isLoadMore {
                                HStack {
                                    ProgressView()
                                }
                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 44, maxHeight: 44, alignment: .center)
                                .onAppear(perform: loadMore)
                            }
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
    
    func loadMore() {
        if self.bloc.state is LoadListLoadPageInProgress {
            return
        }
        
        print("Start LOAD MORE")
        self.bloc.add(event: LoadListNextPage(params: params))
    }

}
