//
//  NetworkError.swift
//  Swift6WithUIKit
//
//  Created by Luis Rodríguez on 2/2/25.
//

import Foundation

enum NetworkError: Error {
    case httpError(statusCode: Int, data: Data)
    case decodingError(Error)
    case unknown(Error)
}
