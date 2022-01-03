//
//  ContactBlocTests.swift
//  boilerplate-swiftui-blocTests
//
//  Created by @camapblue on 1/3/22.
//

import XCTest
import Repository
import Mockingbird
import Combine
import boilerplate_swiftui_bloc

class ContactBlocTests: XCTestCase {
    
    private var contactService: ContactServiceMock!
    private var contactBloc: ContactBloc!
    private var cancellables: Set<AnyCancellable>!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        cancellables = Set<AnyCancellable>()
        contactService = mock(ContactService.self)
        contactBloc = ContactBloc(
            key: "contact_bloc_key",
            contact: Contact.fakeContact(),
            service: contactService
        )
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
    }

    func testInitialize() throws {
        // when
        contactBloc = ContactBloc(
            key: "contact_bloc_key",
            contact: Contact.fakeContact(id: "test_contact_id"),
            service: contactService
        )
        
        // given
        let currentState = contactBloc.state
        let currentContact = currentState.contact
        
        // then
        XCTAssert(currentState is ContactInitial)
        XCTAssert(currentContact.id == "test_contact_id")
    }

}
