//
//  AvatarView.swift
//  boilerplate-swiftui-bloc
//
//  Created by @camapblue on 12/31/21.
//

import Kingfisher
import SwiftUI

struct AvatarView: View {
    var avatar: String
    var size: CGFloat
    
    var body: some View {
        KFImage.url(URL(string: avatar)!)
            .placeholder { Image("avatar_placeholder") }
            .fade(duration: 0.25)
            .resizing(referenceSize: CGSize(width: size, height: size), mode: .aspectFit)
            .clipShape(Circle())
    }
}
