//
//  APIClient.swift
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

/**
 A type representing a generic REST API client.
 
 By conforming structs and classes to this protocol, rewriting URL session code
 can be avoided.
 */
public protocol APIClient {
    
    /// A URL session.
    var session: URLSession { get }
    
}

// MARK: - Protocol Extension | Type Aliases

public extension APIClient {
    
    /// Specifies the type of a JSON object.
    typealias JSON = [String: AnyObject]
    
    /// Specifies the type of a JSON task completion handler.
    typealias JSONTaskCompletionHandler = (JSON?, APIError?) -> Void
    
}

// MARK: - Protocol Extension | Additions

extension APIClient {
    
    func jsonTask(with request: URLRequest, completionHandler completion: @escaping JSONTaskCompletionHandler) -> URLSessionDataTask {
        let task = session.dataTask(with: request) { data, response, error in
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(nil, .requestFailed)
                return
            }
            
            if httpResponse.isOK {
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: []) as? JSON
                        completion(json, nil)
                    } catch {
                        completion(nil, .jsonConversionFailure)
                    }
                } else {
                    completion(nil, .invalidData)
                }
            } else {
                completion(nil, .responseUnsuccessful(statusCode: httpResponse.statusCode))
            }
        }
        
        return task
    }
    
}
