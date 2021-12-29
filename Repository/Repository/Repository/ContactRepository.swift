import Foundation
import Combine

public protocol ContactRepository {
    func fetchContacts() -> Future<[Contact], Error>
    
    func fetchContacts(size: Int) -> Future<[Contact], Error>
}
