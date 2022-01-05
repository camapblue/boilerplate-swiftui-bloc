//
//  Routes.swift
//  boilerplate-swiftui-bloc
//
//  Created by Hao Tran Thien on 05/01/2022.
//

import Repository
import SwiftUI

extension NavigationRouteLink {
    static var splash: NavigationRouteLink { "/splash" }
    static var storyBook: NavigationRouteLink { "/storyBook" }
    static var contactList: NavigationRouteLink { "/contactList" }
    
    static func contactDetails(with contactBloc: ContactBloc) -> NavigationRouteLink {
        NavigationRouteLink(path: "/contact/\(contactBloc.key)", meta: [
            "bloc": contactBloc,
        ])
    }
}

extension Array where Element == NavigationRoute {
    static var all: [NavigationRoute] {
        let splash = NavigationRoute(path: "/splash", destination: SplashView())
        let storyBook = NavigationRoute(path: "/storyBook", destination: Storybook())
        let contactList = NavigationRoute(path: "/contactList", destination: ContactListView())
        let contactDetails = NavigationRoute(path: "/contact/{id}") { route in
            BlocProvider(builder: {
                ContactDetailView()
            }, create: {
                route.link.meta["bloc"] as! ContactBloc
            })
        }
        
        return [splash, storyBook, contactList, contactDetails]
    }
}
