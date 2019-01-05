//
//  HTTPURLResponse+NetworkKit.swift
//  NetworkKit
//
//  Created by Robert L. Jones on 1/5/18.
//  Copyright © 2018 Synthelytics LLC. All rights reserved.
//
//  REFEERENCES:
//  1. http://www.iana.org/assignments/http-status-codes/http-status-codes.xhtml
//  2. https://en.wikipedia.org/wiki/List_of_HTTP_status_codes
//

import Foundation

// MARK: - Public Class Extension | Additions | Response Class/Status

public extension HTTPURLResponse {
    
    // MARK: Enums
    
    /**
     Constants indicating the class of HTTP response status code.
     
     As tempting as it would be to define a `StatusCode` enum, it doesn't seem
     practical to do so.  Aside from the number of individual statuus codes to
     manage, there is the issue of language localization.  This is better
     handled via the `HTTPURLResponse` method `localizedString(forStatusCode:)`.
     */
    enum StatusClass {
        
        /**
         An indication that the request was received, continuing the process.
         
         Represents the class of HTTP response status codes of the form 1xx.
         */
        case informational
 
        /**
         An indication that the action was successfully received, understood,
         and accepted.
         
         Represents the class of HTTP response status codes of the form 2xx.
         */
        case success
        
        /**
         An indication that further action must be taken in order to complete
         the request.
         
         Represents the class of HTTP response status codes of the form 3xx.
         */
        case redirection
 
        /**
         An indication that the request contains bad syntax or cannot be
         fulfilled.
         
         Represents the class of HTTP response status codes of the form 4xx.
         */
        case clientError
 
        /**
         An indication that the server failed to fulfill an apparently valid
         request.
         
         Represents the class of HTTP response status codes of the form 5xx.
         */
        case serverError
 
        /**
         An indication that the status code value is outside of the defined
         range.
         */
        case undefined
    }
    
    /// Boolean value indicating whether the HTTP request succeeeded.
    var isOK: Bool {
        return statusCode == 200
    }
    
    /// The response's HTTP status class.
    var statusClass: StatusClass {
        switch statusCode {
        case 100..<200: return .informational
        case 200..<300: return .success
        case 300..<400: return .redirection
        case 400..<500: return .clientError
        case 500..<600: return .serverError
        default: return .undefined
        }
    }
    
}
