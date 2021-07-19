//
//  LoginViewModelTests.swift
//  MockBankingAppTests
//
//  Created by Damon on 19/7/21.
//

import XCTest
import CoreData
@testable import MockBankingApp

class LoginViewModelTests: XCTestCase {
    
    var viewModel: LoginViewModel!

    override func setUp() {
        viewModel = .init()
    }
    
    func testLogin() {
        let coreDataContext = MockCoreData().persistentContainer.newBackgroundContext()
        let result = viewModel.login(username: "Alice", context: coreDataContext)
        XCTAssertTrue(result)
    }

}
