//
//  Router.swift
//  Router
//
//  Created by Parveen Kaler on 9/7/15.
//  Copyright © 2015 Smartful Studios Inc. All rights reserved.
//

import Foundation

public class Router {
    
    public typealias Action = ([NSURLQueryItem], [NSURLQueryItem])->()
    var routeMap = [Route:Action]()
    var routeList = [Route]()
    
    public init() {}
    
    public func route(aRoute: String, action: Action) {
        let route = Route(aRoute: aRoute)
        routeList.append(route)
        routeMap[route] = action
    }
    
    public func match(url: NSURL) {
        let (pathname, queryParams) = urlToPathname(url)
        for route in routeList {
            let range = NSMakeRange(0, pathname.characters.count)
            if let match = route.regex.firstMatchInString(pathname, options: NSMatchingOptions(rawValue: 0), range: range) {
                if let action = routeMap[route] {
                    var urlParams: [NSURLQueryItem] = [NSURLQueryItem]()
                    for i in 1 ..< match.numberOfRanges {
                        let name = ":id"
                        let value = (pathname as NSString).substringWithRange(match.rangeAtIndex(i))
                        urlParams.append(NSURLQueryItem(name: name, value: value))
                    }
                    action(urlParams, queryParams)
                    return
                }
            }
        }
    }
    
    func urlToPathname(url: NSURL) -> (String, [NSURLQueryItem]) {
        guard let components = NSURLComponents(URL: url, resolvingAgainstBaseURL: false) else {
            return ("", [])
        }

        var pathname = ""
        if let host = components.host {
            pathname += "/\(host)"
        }
        
        if let path = components.path {
            pathname += path
        }

        let queryParams = components.queryItems ?? []
        
        return (pathname, queryParams)
    }
}