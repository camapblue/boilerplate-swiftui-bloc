//
//  boilerplate_swiftui_blocTests-boilerplate_swiftui_blocMocks.generated.swift
//  boilerplate_swiftui_bloc
//
//  Generated by Mockingbird v0.18.1.
//  DO NOT EDIT
//

@testable import Mockingbird
@testable import boilerplate_swiftui_bloc
import Combine
import Foundation
import Kingfisher
import Repository
import Storybook
import Swift
import SwiftBloc
import SwiftUI
import SwiftUIRefresh
import UIKit
private let genericStaticMockContext = Mockingbird.GenericStaticMockContext()

// MARK: - Mocked ContactService
public final class ContactServiceMock: boilerplate_swiftui_bloc.ContactService, Mockingbird.Mock {
  typealias MockingbirdSupertype = boilerplate_swiftui_bloc.ContactService
  static let staticMock = Mockingbird.StaticMock()
  public let mockingbirdContext = Mockingbird.Context(["generator_version": "0.18.1", "module_name": "boilerplate_swiftui_bloc"])

  fileprivate init(sourceLocation: Mockingbird.SourceLocation) {
    self.mockingbirdContext.sourceLocation = sourceLocation
    ContactServiceMock.staticMock.mockingbirdContext.sourceLocation = sourceLocation
  }

  // MARK: Mocked `edit`(`contact`: Contact)
  public func `edit`(`contact`: Contact) -> Future<Contact, Error> {
    return self.mockingbirdContext.mocking.didInvoke(Mockingbird.SwiftInvocation(selectorName: "`edit`(`contact`: Contact) -> Future<Contact, Error>", selectorType: Mockingbird.SelectorType.method, arguments: [Mockingbird.ArgumentMatcher(`contact`)], returnType: Swift.ObjectIdentifier((Future<Contact, Error>).self))) {
      self.mockingbirdContext.recordInvocation($0)
      let mkbImpl = self.mockingbirdContext.stubbing.implementation(for: $0)
      if let mkbImpl = mkbImpl as? (Contact) -> Future<Contact, Error> { return mkbImpl(`contact`) }
      if let mkbImpl = mkbImpl as? () -> Future<Contact, Error> { return mkbImpl() }
      for mkbTargetBox in self.mockingbirdContext.proxy.targets(for: $0) {
        switch mkbTargetBox.target {
        case .super:
          break
        case .object(let mkbObject):
          guard var mkbObject = mkbObject as? MockingbirdSupertype else { break }
          let mkbValue: Future<Contact, Error> = mkbObject.`edit`(contact: `contact`)
          self.mockingbirdContext.proxy.updateTarget(&mkbObject, in: mkbTargetBox)
          return mkbValue
        }
      }
      if let mkbValue = self.mockingbirdContext.stubbing.defaultValueProvider.value.provideValue(for: (Future<Contact, Error>).self) { return mkbValue }
      self.mockingbirdContext.stubbing.failTest(for: $0, at: self.mockingbirdContext.sourceLocation)
    }
  }

  public func `edit`(`contact`: @autoclosure () -> Contact) -> Mockingbird.Mockable<Mockingbird.FunctionDeclaration, (Contact) -> Future<Contact, Error>, Future<Contact, Error>> {
    return Mockingbird.Mockable<Mockingbird.FunctionDeclaration, (Contact) -> Future<Contact, Error>, Future<Contact, Error>>(mock: self, invocation: Mockingbird.SwiftInvocation(selectorName: "`edit`(`contact`: Contact) -> Future<Contact, Error>", selectorType: Mockingbird.SelectorType.method, arguments: [Mockingbird.resolve(`contact`)], returnType: Swift.ObjectIdentifier((Future<Contact, Error>).self)))
  }
}

/// Returns a concrete mock of `ContactService`.
public func mock(_ type: boilerplate_swiftui_bloc.ContactService.Protocol, file: StaticString = #file, line: UInt = #line) -> ContactServiceMock {
  return ContactServiceMock(sourceLocation: Mockingbird.SourceLocation(file, line))
}
