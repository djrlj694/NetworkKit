//
//  QueryItemProvider.swift
//  NetworkKit
//
//  Created by Robert L. Jones on 12/31/18.
//  Copyright © 2018 Synthelytics LLC. All rights reserved.
//
//  REFERENCES:
//  1. iTunesClient: https://teamtreehouse.com/library/wrapping-up-11
//

import Foundation

// MARK: - Public Protocol Declaration

/// Requires conforming types to provide an instance of `URLQueryItem`.
public protocol QueryItemProvider {
    
    /// A single name-value pair from the query portion of a URL.
    var queryItem: URLQueryItem { get }
    
}
