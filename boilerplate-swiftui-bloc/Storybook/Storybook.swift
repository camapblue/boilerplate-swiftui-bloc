//
//  Storybook.swift
//  boilerplate-swiftui-bloc
//
//  Created by @camapblue on 1/2/22.
//

import SwiftUI
import Storybook

struct Storybook: View {
    var body: some View {
        StorybookView(stories: [
            Story("Avatar View") { AvatarViewStory() }
        ])
    }
}
