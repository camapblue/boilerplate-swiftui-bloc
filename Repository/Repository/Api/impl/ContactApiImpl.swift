//
//  File.swift
//  
//
//  Created by @camapblue on 12/28/21.
//

import Foundation
import Combine

class ContactApiImpl: ContactApi {
    func fetchContacts(withSize size: Int = 5) -> Future<[Contact], Error> {
        let url = URL(string: "https://randomuser.me/api/?results=\(size)")!
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

