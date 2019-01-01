//
//  APIError.swift
//  NetworkKit
//
//  Created by Robert L. Jones on 1/1/18.
//  Copyright © 2018 Synthelytics LLC. All rights reserved.
//
//  REFERENCES:
//  1. CodablePostRequest: https://github.com/jamesrochabrun/CodablePostRequest
//  2. iTunesClient: https://teamtreehouse.com/library/wrapping-up-11
//  3. ProtocolBasedNetworking: https://github.com/jamesrochabrun/ProtocolBasedNetworking/tree/master/ProtocolBasedNetworkingTutorialFinal
//  4. RestaurantReviews: https://teamtreehouse.com/library/the-end-5
//  5. Stormy: https://teamtreehouse.com/library/the-end-6
//  6. https://medium.com/@jamesrochabrun/protocol-based-generic-networking-using-jsondecoder-and-decodable-in-swift-4-fc9e889e8081
//  7. https://medium.com/@jamesrochabrun/protocol-based-generic-networking-part-2-jsonencoder-and-encodable-for-post-request-in-swift-27ebd301c314
//

import Foundation

/**
 An error that occurs during an attempt to retrieve or process a HTTP GET
 response from a REST API service.
 */
enum APIError: Error {
    
    /// An indication that an HTTP GET request did not yield an HTTP reponse.
    case requestFailed
    
    /**
     An indication that an HTTP GET request yielded an HTTP reponse with a
     status code other than 200 (i.e, "OK").
     */
    case responseUnsuccessful(statusCode: Int)
    
    /**
     An indication that an HTTP GET request yielded an HTTP reponse without
     data.
     */
    case invalidData
    
    /**
     An indication that the attempt to serialize JSON data to a dictionary
     object failed.
     */
    case jsonConversionFailure // iTunes
    
    /**
     An indication that the attempt to parse and convert JSON data to one or
     * more model objects failed.
     */
    case jsonParsingFailure(message: String) // DarkSky
    
    /**
     An indication that the URL was not constructed or is syntactically
     invalid.
     */
    case invalidUrl
    
    /**
     An indication that the attempt to encode an HTTP POST request's parameters
     to JSON failed.
     */
    case postParametersEncodingFalure(message: String)
    
}

extension APIError {
    
    /// A localized string corresponding to a specified API error.
    var localizedDescription: String {
        switch self {
        case .responseUnsuccessful: return "Response Unsuccessful"
        case .requestFailed: return "Request Failed"
        case .invalidData: return "Invalid Data"
        case .jsonConversionFailure: return "JSON Conversion Failure"
        case .jsonParsingFailure: return "JSON Parsing Failure"
        case .invalidUrl: return "Invalid URL"
        case .postParametersEncodingFalure: return "POST Parameters Failure"
        }
    }
    
}

