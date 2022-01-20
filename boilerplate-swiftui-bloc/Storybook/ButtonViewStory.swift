//
//  ButtonViewStory.swift
//  boilerplate-swiftui-bloc
//
//  Created by @camapblue on 1/9/22.
//

import SwiftUI

struct ButtonViewStory: View {
    var body: some View {
        VStack {
            SpacerView(height: 128)
            ButtonView.primary("Primary Button") {
                print("Primary Action Now!")
            }
            .padding(.horizontal, 32)
            SpacerView(height: 128)
            ButtonView.primary(
                "Padding Button",
                padding: EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
            ) {
                print("Padding Action Now!")
            }
            SpacerView(height: 128)
            ButtonView.secondary("Secondary Button") {
                print("Secondary Action Now!")
            }
            .padding(.horizontal, 32)
            SpacerView(height: 128)
            ButtonView.secondary(
                "Secondary Padding",
                padding: EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
            ) {
                print("Secondary Padding Now!")
            }
            SpacerView(height: 128)
        }
    }
}
