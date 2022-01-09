//
//  ContactListServiceTests.swift
//  boilerplate-swiftui-blocTests
//
//  Created by @camapblue on 1/8/22.
//

import XCTest
import Combine
import Mockingbird
import Repository
import boilerplate_swiftui_bloc

class ContactListServiceTests: XCTestCase {
    
    private var contactRepository: ContactRepostioryMock!
    private var contactListService: LoadListService<Contact>!
    private var cancellables: Set<AnyCancellable>!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        cancellables = Set<AnyCancellable>()
        contactRepository = mock(ContactRepository.self)
        contactListService = ContactListServiceImpl(contactRepository: contactRepository)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
    }

    func testFetchContactsSuccesss() throws {
        // when
        given(contactRepository.fetchContacts(withSize: 5)).willReturn(
            Future { promise in
                let items = [Contact.fakeContact()]
                promise(.success(items))
            }
        )
        
        // given
        var contacts = [Contact]()
        var error: Error?
        let expectation = self.expectation(description: "Awaiting publisher")
        try! contactListService
            .loadItems()
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let encounteredError):
                    error = encounteredError
                }

                expectation.fulfill()
            } receiveValue: { value in
                contacts = value
            }
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 10)
        
        // then
        XCTAssertNil(error)
        XCTAssertEqual(contacts.count, 1)
    }

}

