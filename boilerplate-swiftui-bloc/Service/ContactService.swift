//
//  ContactService.swift
//  boilerplate-swiftui-bloc
//
//  Created by @camapblue on 12/28/21.
//

import Foundation
import Combine
import Repository

protocol ContactService {
    func getCachedContacts() -> Future<[Contact], Error>
}
