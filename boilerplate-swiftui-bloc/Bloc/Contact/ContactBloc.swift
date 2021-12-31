//
//  ContactBloc.swift
//  boilerplate-swiftui-bloc
//
//  Created by @camapblue on 12/31/21.
//

import Combine
import Repository

class ContactBloc: BaseBloc<ContactEvent, ContactState> {
    private var contactService: ContactService
    
    init(key: String, contact: Contact, service: ContactService) {
        self.contactService = service
        
        super.init(key: key, inititalState: ContactInitial(contact: contact))
    }
    
    override func mapEventToState(event: ContactEvent) -> AnyPublisher<ContactState, Never> {
        if event is ContactEdited {
            mapEventEditedToState(event: event as! ContactEdited)
        }
        return emitter.eraseToAnyPublisher()
    }
    
    private func mapEventEditedToState(event: ContactEdited) {
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
                        self.emitter.send(ContactEditFailure(contact: self.state.contact))
                    }
                }
            }, receiveValue: { [weak self] updatedContact in
                let nextState = ContactEditSuccess(contact: updatedContact)
                self?.emitter.send(nextState)
            })
            .store(in: &self.disposables)
    }
}
