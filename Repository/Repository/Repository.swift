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
    func baseUrl() -> BaseUrl {
        return BaseUrl(apiEndpointUrl: RepositoryConfigs.shared.apiEndpointUrl)
    }
    
    func contactApi() -> ContactApi {
        return ContactApiImpl(baseUrl: baseUrl())
    }
    
    // Dao
    func contactDao() -> ContactDao {
        return ContactDaoImpl()
    }
}
