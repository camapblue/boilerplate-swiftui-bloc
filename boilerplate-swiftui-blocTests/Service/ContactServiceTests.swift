//
//  ContactServiceTests.swift
//  boilerplate-swiftui-blocTests
//
//  Created by @camapblue on 1/3/22.
//

import XCTest
import Combine
import Mockingbird
import Repository
import boilerplate_swiftui_bloc

class ContactServiceTests: XCTestCase {
    
    private var contactRepository: ContactRepostioryMock!
    private var contactService: ContactService!
    private var cancellables: Set<AnyCancellable>!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        cancellables = Set<AnyCancellable>()
        contactRepository = mock(ContactRepository.self)
        contactService = ContactServiceImpl(contactRepository: contactRepository)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
    }

    func testFetchContactsSuccesss() throws {
        var editingContact = Contact.fakeContact()
        
        // when
        given(contactRepository.edit(contact: any())).willReturn(
            Future { promise in
                promise(.success(Contact.fakeContact()))
            }
        )
        
        // given
        
        var updatedContact: Contact?
        var error: Error?
        let expectation = self.expectation(description: "Awaiting publisher")
        contactService
            .edit(contact: editingContact)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let encounteredError):
                    error = encounteredError
                }

                expectation.fulfill()
            } receiveValue: { value in
                updatedContact = value
            }
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 10)
        
        // then
        XCTAssertNil(error)
        XCTAssertNotNil(updatedContact)
    }

}
