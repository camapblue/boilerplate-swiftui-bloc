//
//  File.swift
//  
//
//  Created by @camapblue on 12/28/21.
//

import Foundation
import Combine

class ContactRepositoryImpl: ContactRepository {
    
    private var contactDao: ContactDao!
    private var contactApi: ContactApi!
    
    init(contactDao: ContactDao, contactApi: ContactApi) {
        self.contactApi = contactApi
        self.contactDao = contactDao
    }
    
    func fetchContacts() -> Future<[Contact], Error> {
        return fetchContacts(size: 5)
    }
    
    func fetchContacts(size: Int) -> Future<[Contact], Error> {
        return Future { [weak self] promise in
            guard let self = self else {
                promise(.success([Contact]()))
                return
            }
            if let cached = self.contactDao.getCachedContacts() {
                promise(.success(cached))
                return
            }
            
            self.contactApi.fetchContacts(withSize: size)
                .sink { completion in
                    
                } receiveValue: { value in
                    self.contactDao.cacheContacts(contacts: value)
                    promise(.success(value))
                }.cancel()

        }
    }
}
