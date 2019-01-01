//
//  PendingOperations.swift
//  NetworkKit
//
//  Created by Robert L. Jones on 12/31/18.
//  Copyright © 2018 Synthelytics LLC. All rights reserved.
//
//  REFERENCES:
//  1. iTunesClient: https://teamtreehouse.com/library/wrapping-up-11
//

import Foundation

// MARK: - Public Class Declaration

/**
 Keeps track of pending media download / queuing operations.
 
 Can be used to associate a download operation with the index path of, say, a
 table or collection view so that media download operations aren't:
 * Continuing when a portion of a table / collection scrolls off screen;
 * Duplicated when a table / collection view is reloaded.
 */
public class PendingOperations {
    
    // MARK: Stored Instance Properties
    
    /// An operation queue for regulating downloads.
    let downloadQueue = OperationQueue()
    
    /**
     A dictionary for tracking media download operations created and the index
     paths with which each operation is associated.
     */
    var downloadsInProgress = [IndexPath: Operation]()
    
}
