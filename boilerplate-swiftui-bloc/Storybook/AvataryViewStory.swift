//
//  AvataryViewStory.swift
//  boilerplate-swiftui-bloc
//
//  Created by @camapblue on 1/2/22.
//

import SwiftUI

struct AvatarViewStory: View {
    var body: some View {
        VStack {
            SpacerView(height: 128)
            AvatarView(avatar: "https://randomuser.me/api/portraits/med/women/92.jpg", size: 92)
            SpacerView(height: 128)
            AvatarView(avatar: "https://randomuser.me/api/portraits/med/women/64.jpg", size: 64)
            SpacerView(height: 128)
            AvatarView(avatar: "https://randomuser.me/api/portraits/med/women/32.jpg", size: 32)
            SpacerView(height: 128)
            AvatarView(avatar: "https://randomuser.me/api/portraits/med/women/16.jpg", size: 16)
            SpacerView(height: 128)
        }
    }
}
