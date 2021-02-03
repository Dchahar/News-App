//
//  APIError.swift
//  News
//
//  Created by Dheeraj Chahar on 01/02/21.
//

import Foundation

/// Available types for `Error`
enum APIError: String, Error {
    case decodingError = "Unable to decode"
    case fileNotFound = "Unable to find the file"
    case fileCouldNotOpen = "The file couldn’t be opened"
}
