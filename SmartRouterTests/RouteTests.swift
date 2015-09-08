//
//  RouteTests.swift
//  Router
//
//  Created by Parveen Kaler on 9/7/15.
//  Copyright © 2015 Smartful Studios Inc. All rights reserved.
//

import XCTest

class RouteTests: XCTestCase {

    func testTurnBaldRouteToParameter() {
        let route = "/foo"
        let pattern = routeToRegexPattern(route)
        XCTAssert(pattern == "^/foo/?$", "Didn't match pattern: \(pattern)")
    }
    
    func testURLVariable() {
        let route = "/foo/:id"
        let pattern = routeToRegexPattern(route)
        XCTAssert(pattern == "^/foo/([^/]+)/?$", "Didn't match pattern \(pattern)")
    }
    
    func testMultipleURLVariables() {
        let route = "/foo/:id/bar/:id"
        let pattern = routeToRegexPattern(route)
        XCTAssert(pattern == "^/foo/([^/]+)/bar/([^/]+)/?$", "Didn't match pattern \(pattern)")        
    }
}
