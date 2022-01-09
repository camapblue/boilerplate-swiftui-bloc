//
//  Button.swift
//  boilerplate-swiftui-bloc
//
//  Created by @camapblue on 1/9/22.
//

import SwiftUI

struct ButtonView: View {
    var title: String
    var backgroundColor: Color = DesignTokens.colorBaseOrange.color()
    var highlightColor: Color = DesignTokens.colorBaseRed.color()
    var disabledColor: Color = DesignTokens.colorBaseGrayLight.color()
    var textSize: CGFloat = 17
    var textColor: Color = DesignTokens.colorBaseGrayDark.color()
    
    var cornerRadius: CGFloat = 8
    var border: Color?
    var width: CGFloat?
    var height: CGFloat = 44
    var padding: EdgeInsets?
    var disabled: Bool = false
    var action: () -> Void
    
    @SwiftUI.State private var isPressed = false
    
    var body: some View {
        ZStack {
            ZStack {
                Text(title)
                    .primaryBold(
                        fontSize: textSize,
                        color: textColor.opacity(disabled ? 0.5 : 1)
                    )
                    
            }
            .if (padding != nil) { view in
                view.padding(padding!)
            }
            .if (padding == nil) { view in
                view.frame(maxWidth: width ?? .infinity)
            }
            .frame(height: height, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .if (border != nil && !isPressed) { view in
                view.overlay(
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .stroke(border!, lineWidth: 1)
                        .allowsHitTesting(false)
                        .disabled(true)
                )
            }
            .background(
                disabled ? disabledColor
                    : isPressed ? highlightColor : backgroundColor
            )
            .cornerRadius(cornerRadius)
        }
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in
                    isPressed = true
                }
                .onEnded { _ in
                    isPressed = false
                    action()
                }
        )
    }
}

extension ButtonView {
    static func primary(_ title: String, width: CGFloat? = nil, padding: EdgeInsets? = nil, disabled: Bool = false, action: @escaping () -> Void) -> ButtonView {
        return ButtonView(title: title, width: width, padding: padding, disabled: disabled, action: action)
    }
    
    static func secondary(_ title: String, width: CGFloat? = nil, padding: EdgeInsets? = nil, disabled: Bool = false, action: @escaping () -> Void) -> ButtonView {
        return ButtonView(
            title: title,
            backgroundColor: Color.gray.opacity(0),
            highlightColor: DesignTokens.colorBaseGrayLight.color(),
            border: DesignTokens.colorBaseGrayDark.color(),
            width: width,
            padding: padding,
            disabled: disabled,
            action: action
        )
    }
}

