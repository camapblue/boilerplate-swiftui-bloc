//
//  ContactRepository.swift
//  iOSLiveCodingExam1
//
//  Created by @camapblue on 12/28/21.
//

import Foundation

class ContactDaoImpl: ContactDao {
    func getCachedContacts() -> [Contact]? {
        if let data = UserDefaults.standard.data(forKey: "key.contacts") {
            if let lastUpdated = UserDefaults.standard.object(forKey: "key.lastUpdated") as? Date {
                let secondComponents = Calendar.current.dateComponents([.second], from: lastUpdated, to: Date())
                let second = secondComponents.second!
                if second > 120 {
                    return nil
                }
                let decoder = JSONDecoder()
                if let contacts = try? decoder.decode([Contact].self, from: data) {
                    return contacts
                }
            }
        }
        return nil
    }
    
    func cacheContacts(contacts: [Contact]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(contacts) {
            UserDefaults.standard.setValue(encoded, forKey: "key.contacts")
            UserDefaults.standard.setValue(Date(), forKey: "key.lastUpdated")
        }
    }
}
