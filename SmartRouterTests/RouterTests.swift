//
//  RouterTests.swift
//  RouterTests
//
//  Created by Parveen Kaler on 9/7/15.
//  Copyright © 2015 Smartful Studios Inc. All rights reserved.
//

import XCTest
@testable import Router

class RouterTests: XCTestCase {
    
    var router: Router?
    
    override func setUp() {
        super.setUp()
        router = Router()
    }
    
    func testBase() {
        let expectation = expectationWithDescription("Plain")
        router?.route("/foo") { _ in
            expectation.fulfill()
        }
        
        router?.route("/bar") { _ in
            XCTAssert(false, "Should not match bar")
        }
        
        let url = NSURL(string: "/foo")!
        router?.match(url)
        
        waitForExpectationsWithTimeout(0.001) { (error) -> Void in
            print(error)
        }
    }
    
    func testURLParameter() {
        let expectation = expectationWithDescription("URL Parameters")
        router?.route("/foo/:id") { (urlParams, queryParams) in
            XCTAssert(urlParams.first?.name == ":id")
            XCTAssert(urlParams.first?.value == "1234")
            expectation.fulfill()
        }
        
        let url = NSURL(string: "/foo/1234")!
        router?.match(url)
        
        waitForExpectationsWithTimeout(0.001) { (error) -> Void in
            print(error)
        }
    }
    
    func testParameters() {
        let e = expectationWithDescription("Parameter expectation")
        router?.route("/foo") { (urlParams, queryParams) in
            XCTAssert(queryParams.first?.name == "param")
            XCTAssert(queryParams.first?.value == "12345")
            e.fulfill()
        }
        
        let url = NSURL(string: "/foo?param=12345")!
        router?.match(url)
        
        waitForExpectationsWithTimeout(0.001) { (error) -> Void in
            print(error)
        }
    }
}
