//
//  NetworkError.swift
//  ConflictingEvents
//
//  Created by Rafay, Muhammad on 12/14/21.
//

import Foundation
enum NetworkError: Error {
    case requestResourceNotFound
    case parsingError
    case invalidPath
}
