//
//  StorybookView.swift
//  Storybook
//
//  Created by @camapblue on 1/2/22.
//

import SwiftUI

public struct StorybookView<V: View>: View {
    var stories: [Story<V>]
    
    public init(stories: [Story<V>] = [Story<V>]()) {
        self.stories = stories
    }
    
    public var body: some View {
        List(stories, id: \.title) { item in
            StoryRowItem(story: item)
        }
        .navigationTitle("Storybook")
    }
}

