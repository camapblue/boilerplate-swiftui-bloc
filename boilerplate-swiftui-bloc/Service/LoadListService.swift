//
//  LoadListService.swift
//  boilerplate-swiftui-bloc
//
//  Created by @camapblue on 12/29/21.
//

import Foundation
import Combine

open class LoadListService<Item: Equatable> {
    func loadItems() throws -> Future<[Item], Error> { throw "not implemented yet" }
    
    func loadItems(params: [String: AnyObject]?) throws -> Future<[Item], Error> { throw "not implemented yet" }
}
