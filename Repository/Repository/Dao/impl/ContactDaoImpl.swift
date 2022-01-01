//
//  ContactRepository.swift
//  iOSLiveCodingExam1
//
//  Created by @camapblue on 12/28/21.
//

import Foundation

class ContactDaoImpl: ContactDao {
    private var userDefaults: UserDefaults
    init(userDefaults: UserDefaults = UserDefaults.standard) {
        self.userDefaults = userDefaults
    }
    
    func getCachedContacts() -> [Contact]? {
        if let data = userDefaults.data(forKey: "key.contacts") {
            if let lastUpdated = userDefaults.object(forKey: "key.lastUpdated") as? Date {
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
            userDefaults.setValue(encoded, forKey: "key.contacts")
            userDefaults.setValue(Date(), forKey: "key.lastUpdated")
        }
    }
    
    func clearCachedContacts() {
        userDefaults.removeObject(forKey: "key.contacts")
        userDefaults.removeObject(forKey: "key.lastUpdated")
    }
}
