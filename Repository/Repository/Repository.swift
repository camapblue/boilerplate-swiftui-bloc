//
//  repository.swift
//  repository
//
//  Created by @camapblue on 12/28/21.
//

public class Repository {
    public static let shared = Repository()
    
    // Repository
    public func contactRepository() -> ContactRepository {
        return ContactRepositoryImpl(
            contactDao: contactDao(), contactApi: contactApi()
        )
    }
    
    // Api
    func contactApi() -> ContactApi {
        return ContactApiImpl()
    }
    
    // Dao
    func contactDao() -> ContactDao {
        return ContactDaoImpl()
    }
}
