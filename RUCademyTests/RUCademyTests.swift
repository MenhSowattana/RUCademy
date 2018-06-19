//
//  RUCademyTests.swift
//  RUCademyTests
//
//  Created by Sowattana on 6/15/18.
//  Copyright © 2018 Sowattana. All rights reserved.
//

import XCTest
@testable import RUCademy

class RUCademyTests: XCTestCase {
    var loginModel: LoginModel!
    override func setUp() {
        super.setUp()
        loginModel = LoginModel()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testLogin() {
        let expect = expectation(description: "Login info should be admin")
        loginModel.login(email: "sowattana.menh@r-up.jp", password: "Test@168", completition: { (group) in
            XCTAssertNotNil(group, "Cannot get group from response")
            XCTAssertEqual(group.lowercased(), "admin")
            expect.fulfill()
        }) { (message) in
            XCTAssertNotNil(message)
        }
        
        waitForExpectations(timeout: 20) { (error) in
            XCTAssertNil(error, "Test time out. \(error?.localizedDescription ?? "")")
        }
    }
    
}
