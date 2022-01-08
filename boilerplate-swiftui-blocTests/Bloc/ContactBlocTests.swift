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
import SwiftBloc
import boilerplate_swiftui_bloc

class ContactBlocTests: XCTestCase {
    
    private var contactService: ContactServiceMock!
    private var contactBloc: ContactBloc!
    private var cancellables: Set<AnyCancellable>!
    private var blocTesting: BlocTest<ContactState, ContactBloc>!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        cancellables = Set<AnyCancellable>()
        contactService = mock(ContactService.self)
        contactBloc = ContactBloc(
            key: "contact_bloc_key",
            contact: Contact.fakeContact(),
            service: contactService
        )
        blocTesting = BlocTest(bloc: contactBloc)
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

    func testEditSuccess() {
        // when
        let editedContact = Contact.fakeContact(id: "test_contact_id", birthday: Date())
        given(contactService.edit(contact: any())).willReturn(
            Future { promise in
                promise(.success(editedContact))
            }
        )
        
        // given
        let expectation = self.expectation(description: "Awaiting publisher")
        var success = false
        blocTesting.execute(
                act: { bloc in
                    bloc.add(event: ContactEdited(contact: editedContact))
                },
                expect: {
                    [
                        ContactInitial(contact: Contact.fakeContact(id: "test_contact_id")),
                        ContactEditInProgress(contact: Contact.fakeContact(id: "test_contact_id")),
                        ContactEditSuccess(contact: Contact.fakeContact(id: "test_contact_id"))
                    ]
                }
            )
        .sink { result, states in
            success = result
            expectation.fulfill()
        }
        .store(in: &cancellables)
        waitForExpectations(timeout: 10)
        
        // then
        XCTAssertTrue(success)
    }
}
