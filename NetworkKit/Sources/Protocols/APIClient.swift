//
//  APIClient.swift
//  NetworkKit
//
//  Created by Robert L. Jones on 1/4/19.
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
    
    /**
     Download and parse JSON from the response of an HTTP GET request to a
     nullable generic data model.
     
     - Parameters:
         - request: TBD.
         - parse: TBD.
     - completion: TBD.
     - Returns: TBD.
     */
    func fetch<T>(
        with request: URLRequest,
        parse: @escaping (JSON) -> (T?, String),
        completion: @escaping (Result<T, APIError>
        ) -> Void)
    
    /**
     Download and parse JSON from the response of an HTTP GET request to an
     array of generic data models.
     
     - Parameters:
         - request: TBD.
         - parse: TBD.
         - completion: TBD.
     - Returns: TBD.
     */
    func fetch<T>(
        with request: URLRequest,
        parse: @escaping (JSON) -> ([T], String),
        completion: @escaping (Result<[T], APIError>
        ) -> Void)
    
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

// MARK: - Protocol Extension | Defaults

extension APIClient {
    
    func fetch<T>(with request: URLRequest, parse: @escaping (JSON) -> (T?, String), completion: @escaping (Result<T, APIError>) -> Void) {
        
        let task = jsonTask(with: request) { json, error in
            
            DispatchQueue.main.async {
                guard let json = json else {
                    if let error = error {
                        completion(Result.failure(error))
                    } else {
                        completion(Result.failure(.invalidData))
                    }
                    
                    return
                }
                
                let (value, message) = parse(json)
                
                if let value = value {
                    completion(.success(value))
                } else {
                    completion(.failure(.jsonParsingFailure(message: message)))
                }
            }
        }
        
        task.resume()
    }
    
    func fetch<T>(with request: URLRequest, parse: @escaping (JSON) -> ([T], String), completion: @escaping (Result<[T], APIError>) -> Void) {
        
        let task = jsonTask(with: request) { json, error in
            
            DispatchQueue.main.async {
                guard let json = json else {
                    if let error = error {
                        completion(Result.failure(error))
                    } else {
                        completion(Result.failure(.invalidData))
                    }
                    
                    return
                }
                
                let (value, message) = parse(json)
                
                if !value.isEmpty {
                    completion(.success(value))
                } else {
                    completion(.failure(.jsonParsingFailure(message: message)))
                }
            }
        }
        
        task.resume()
    }
    
}
