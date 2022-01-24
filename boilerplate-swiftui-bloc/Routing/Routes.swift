//
//  Routes.swift
//  boilerplate-swiftui-bloc
//
//  Created by Hao Tran Thien on 05/01/2022.
//

import Repository
import SwiftUI
import SwiftBloc
import POC_Common_UI_iOS

extension NavigationRouteLink {
    static var splash: NavigationRouteLink { "/splash" }
    static var contactList: NavigationRouteLink { "/contactList" }
    
    static func contactDetails(with contactId: String) -> NavigationRouteLink {
        NavigationRouteLink(path: "/contact/\(contactId)", meta: [
            "contactId": contactId,
        ])
    }
}

extension Array where Element == NavigationRoute {
    static var all: [NavigationRoute] {
        let splash = NavigationRoute(path: "/splash", destination: SplashScreen())
        
        let contactList = NavigationRoute(path: "/contactList") {
            ContactListScreen()
                .provideBloc(create: {
                    Blocs().contactListBloc()
                })
        }
        
        let contactDetails = NavigationRoute(path: "/contact/{id}") { route in
            ContactDetailScreen()
                .provideBloc(create: {
                    BlocManager.shared.blocByKey(
                        key: Keys.Bloc.contactBlocById(id: route.link.meta["contactId"] as! String)
                    ) as! ContactBloc
                })
        }
        
        return [splash, contactList, contactDetails]
    }
}
