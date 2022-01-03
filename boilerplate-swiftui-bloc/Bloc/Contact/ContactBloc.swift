//
//  ContactBloc.swift
//  boilerplate-swiftui-bloc
//
//  Created by @camapblue on 12/31/21.
//

import Combine
import Repository
import SwiftBloc

public class ContactBloc: BaseBloc<ContactEvent, ContactState> {
    private var contactService: ContactService
    
    public init(key: String, closeWithBlocKey: String? = nil, contact: Contact, service: ContactService) {
        self.contactService = service
        
        super.init(
            key: key,
            closeWithBlocKey: closeWithBlocKey,
            inititalState: ContactInitial(contact: contact)
        )
        
        onEvent(ContactEdited.self, handler: { [weak self] event, emitter in
            self?.onContactEditedEvent(event: event, emitter: emitter)
        })
    }
    
    private func onContactEditedEvent(event: ContactEdited, emitter: Emitter<ContactState>) {
        emitter.send(ContactEditInProgress(contact: state.contact))
        
        self.contactService.edit(contact: event.contact)
            .delay(for: 2, scheduler: RunLoop.main)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(_):
                    if let self = self {
                        emitter.send(ContactEditFailure(contact: self.state.contact))
                    }
                }
            }, receiveValue: { updatedContact in
                let nextState = ContactEditSuccess(contact: updatedContact)
                emitter.send(nextState)
            })
            .store(in: &self.disposables)
    }
}
