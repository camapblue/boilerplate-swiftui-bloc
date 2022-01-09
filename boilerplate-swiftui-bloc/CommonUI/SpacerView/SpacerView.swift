//
//  SpaceView.swift
//  boilerplate-swiftui-bloc
//
//  Created by @camapblue on 1/9/22.
//

import SwiftUI

struct SpacerView: View {
    var width: CGFloat = 1
    var height: CGFloat = 1
    
    var body: some View {
        Rectangle().fill(Color.clear)
            .frame(width: width, height: height)
    }
}

