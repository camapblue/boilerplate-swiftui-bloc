//
//  Configs.swift
//  boilerplate-swiftui-bloc
//
//  Created by @camapblue on 1/2/22.
//

import Foundation

final class Configs {
    static let shared = Configs()
    
    var isStorybook: Bool
    
    init() {
        isStorybook = AppEnvironment.isStorybook
    }
}
