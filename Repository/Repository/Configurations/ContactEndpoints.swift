//
//  ContactEndpoints.swift
//  Repository
//
//  Created by Hao Tran Thien on 06/01/2022.
//

import Foundation

enum ContactEndpoints {
    case fetchContacts(size: Int)
}

extension ContactEndpoints {
    var apiEndpointUrl: String {
        return RepositoryConstants.shared.apiEndpointUrl
    }
    
    var path: String {
        switch self {
        case .fetchContacts(let size):
            return "/?results=\(size)"
        }
    }
    
    var url: URL {
        return URL(string: "\(apiEndpointUrl)\(path)")!
    }
}

