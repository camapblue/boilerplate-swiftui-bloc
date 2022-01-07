//
//  File.swift
//  
//
//  Created by @camapblue on 12/28/21.
//

import Foundation
import Combine

public class ContactApiImpl: ContactApi {
    private let baseUrl: BaseUrl
    
    init(baseUrl: BaseUrl) {
        self.baseUrl = baseUrl
    }
    
    public func fetchContacts(withSize size: Int = 5) -> Future<[Contact], Error> {
        let url = baseUrl.getUrl(of: .fetchContacts(size: 5))
        return Future { [weak self] promise in
            guard self != nil else {
                promise(.success([Contact]()))
                return
            }
            let task = URLSession.shared
                .dataTask(with: url) { data, _, error in
                    if error == nil {
                        if let json = try! JSONSerialization.jsonObject(with: data ?? Data(), options: []) as? [String: Any] {
                            let list = json["results"] as! [Dictionary<String, Any>]
                            let contacts = list.map { Contact(dictionary: $0) }
                            promise(.success(contacts))
                            return
                        }
                        promise(.success([Contact]()))
                    } else {
                        promise(.failure(error!))
                    }
                }
            task.resume()
        }
    }
}

