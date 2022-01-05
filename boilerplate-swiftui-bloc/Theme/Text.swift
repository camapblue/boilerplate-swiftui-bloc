//
//  Text.swift
//  boilerplate-swiftui-bloc
//
//  Created by @camapblue on 1/5/22.
//

import SwiftUI

extension Text {
    public func primaryRegular(fontSize: CGFloat =  13, color: Color = Color(StyleDictionary.colorBaseGrayDark)) -> Text {
        return self.font(.custom(StyleDictionary.fontFamilyPrimary, size: fontSize))
            .foregroundColor(color)
    }
    
    public func primaryBold(fontSize: CGFloat =  13, color: Color = Color(StyleDictionary.colorBaseGrayDark)) -> Text {
        return self.primaryRegular(fontSize: fontSize, color: color)
            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
    }
    
    public func secondaryRegular(fontSize: CGFloat =  13, color: Color = Color(StyleDictionary.colorBaseGrayDark)) -> Text {
        return self.font(.custom(StyleDictionary.fontFamilySecondary, size: fontSize))
            .foregroundColor(color)
    }
}
