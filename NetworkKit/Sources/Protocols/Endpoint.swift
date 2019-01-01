//
//  Endpoint.swift
//  NetworkKit
//
//  Created by Robert L. Jones on 1/1/19.
//  Copyright © 2018 Synthelytics LLC. All rights reserved.
//
//  REFERENCES:
//  1. RestaurantReviews: https://teamtreehouse.com/library/the-end-5
//

import Foundation

// MARK: - Public Protocol Declaration

/// A type that computes a `URLRequest` instance for a defined API endpoint.
public protocol Endpoint {
    
    /// The base URL for the API as a string.
    var base: String { get }
    
    /// The URL path for an endpoint as a string.
    var path: String { get }
    
    /**
     The URL parameters for a given endpoint as an array of `URLQueryItem`
     values.
     */
    var queryItems: [URLQueryItem] { get }
    
}

// MARK: - Protocol Extension | Additions

extension Endpoint {
    
    // MARK: Computed Instance Properties
    
    /**
     An instance of `URLComponents` containing the base URL, path, and query
     items provided.
     */
    var urlComponents: URLComponents {
        // TODO: Determine which is better: to force unwrap an optional or to `guard` it.
        var components = URLComponents(string: base)!
        
        components.path = path
        components.queryItems = queryItems
        
        return components
    }
    
    /**
     An instance of `URLRequest` encapsulating the endpoint URL, which is
     obtained through the `urlComponents` object.
     */
    var request: URLRequest {
        // TODO: Determine which is better: to force unwrap an optional or to `guard` it.
        let url = urlComponents.url!
        
        return URLRequest(url: url)
    }
    
    // MARK: Instance Methods
    
    /**
     Creates an instance of `URLRequest` encapsulating both the endpoint URL,
     which is obtained through the `urlComponents` object, and an OAuth token.
     
     The OAuth token is stored in the HTTP `Authorization` request header field
     of the `URLRequeest` instance as a `Bearer` token.
     
     - Parameters:
         - oauthToken: An OAuth token.
     - Returns: An instance of `URLRequest` containing an OAuth token in the
     HTTP `Authorization` request header field.
     */
    func requestWithAuthorizationHeader(oauthToken: String) -> URLRequest {
        var oauthRequest = request
        
        oauthRequest.addValue("Bearer \(oauthToken)", forHTTPHeaderField: "Authorization")
        
        return oauthRequest
    }

}
