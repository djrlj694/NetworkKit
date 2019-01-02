//
//  Result.swift
//  NetworkKit
//
//  Created by Robert L. Jones on 1/1/19.
//  Copyright © 2018 Synthelytics LLC. All rights reserved.
//
//  REFERENCES:
//  1. RestaurantReviews: https://teamtreehouse.com/library/the-end-5
//  2. https://github.com/apple/swift-evolution/blob/master/proposals/0235-add-result.md
//  3. https://forums.swift.org/t/accepted-with-modifications-se-0235-add-result-to-the-standard-library/18603
//  4. https://forums.swift.org/t/revised-se-0235-add-result-to-the-standard-library/18371
//  5. https://www.swiftbysundell.com/posts/the-power-of-result-types-in-swift
//

import Foundation
import ResourceKit

// MARK: - Public Enum Declaration

/**
 A value that represents either a success or failure, capturing associated
 values in both cases.
 */
public enum Result<Success, Failure: Swift.Error> {
    
    /// An indication that a result succeeded.
    case success(Success)
    
    /// An indication that a result failure.
    case failure(Failure)
    
}

// MARK: - Public Enum Extension | Additions

public extension Result {
    
    func resolve() throws -> Success {
        switch self {
        case .success(let value): return value
        case .failure(let error): throw error
        }
    }
    
}

// MARK: - Public Enum Extension | Data

public extension Result where Success == Data {
    
    func decoded<T: Decodable>(using decoder: AnyDecoder = JSONDecoder()) throws -> T {
        let data = try resolve()
        
        return try data.decoded(using: decoder)
    }
    
}
