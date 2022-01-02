//
//  Storybook.swift
//  Storybook
//
//  Created by @camapblue on 1/2/22.
//

import SwiftUI

public typealias StoryViewBuilder<V: View> = () -> V

public class Story<V: View> {
    var title: String
    var builder: StoryViewBuilder<V>
    
    public init(_ title: String, builder: @escaping StoryViewBuilder<V>) {
        self.title = title
        self.builder = builder
    }
}

struct StoryLazyView<Content: View>: View {
    let build: () -> Content
    
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    
    var body: Content {
        build()
    }
}


struct StoryView<V: View>: View {
    var title: String
    var builder: StoryViewBuilder<V>
    
    init(title: String, _ builder: @autoclosure @escaping StoryViewBuilder<V>) {
        self.title = title
        self.builder = builder
    }
    
    var body: some View {
        ZStack {
            ScrollView {
                builder()
            }
        }.navigationTitle(self.title)
    }
}

struct StoryRowItem<V: View>: View {
    var story: Story<V>
    
    init(story: Story<V>) {
        self.story = story
    }
    
    var body: some View {
        HStack {
            NavigationLink(
                destination: StoryLazyView(
                        StoryView<V>(title: story.title, story.builder())
                    )
                ) {
                    Text(story.title)
                }
        }
    }
}
