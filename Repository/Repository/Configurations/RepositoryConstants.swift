//
//  RepositoryConstants.swift
//  Repository
//
//  Created by Hao Tran Thien on 06/01/2022.
//

import Foundation

final class RepositoryConstants {
    static let shared = RepositoryConstants()
    
    var apiEndpointUrl: String {
        AppEnvironment.apiEnpointUrl
    }
}
