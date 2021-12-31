//
//  LazyView.swift
//  boilerplate-swiftui-bloc
//
//  Created by @camapblue on 12/31/21.
//

import SwiftUI

struct LazyView<Content: View>: View {
    let build: () -> Content
    
    init(_ build: @autoclosure @escaping () -> Content) {
        print("LAZY VIEW NOW")
        self.build = build
    }
    
    var body: Content {
        build()
    }
}
