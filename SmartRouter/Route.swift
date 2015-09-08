//
//  Route.swift
//  Router
//
//  Created by Parveen Kaler on 9/7/15.
//  Copyright © 2015 Smartful Studios Inc. All rights reserved.
//

import Foundation

public struct Route {
    let route: String
    let regex: NSRegularExpression
    
    public init(aRoute: String) {
        route = aRoute
        let regexPattern = routeToRegexPattern(aRoute)
        regex = try! NSRegularExpression(pattern: regexPattern, options: [.CaseInsensitive])
    }
}

extension Route: Equatable {}

public func ==(lhs: Route, rhs: Route) -> Bool {
    return lhs.route == rhs.route
}

extension Route: Hashable {
    public var hashValue: Int {
        return self.route.hashValue
    }
    
}

func routeToRegexPattern(aRoute: String) -> String {
    var routeRegex : NSString = "^\(aRoute)/?$"
    let routeParameter = try! NSRegularExpression(pattern: ":[a-zA-Z0-9-_]+", options: .CaseInsensitive)
    let matches = routeParameter.matchesInString(aRoute, options: NSMatchingOptions(rawValue: 0),
        range: NSMakeRange(0, aRoute.characters.count))
    
    var offset = 0
    for match in matches {
        let matchOffset = NSRange(location: match.range.location + 1 + offset, length: match.range.length)
        let urlParam = routeRegex.substringWithRange(matchOffset)
        let urlParamPattern = "([^/]+)"
        routeRegex = routeRegex.stringByReplacingOccurrencesOfString(urlParam, withString: urlParamPattern,
            options: NSStringCompareOptions.LiteralSearch,
            range: matchOffset)
        offset += urlParamPattern.characters.count - urlParam.characters.count
    }
    
    return routeRegex as String
}

