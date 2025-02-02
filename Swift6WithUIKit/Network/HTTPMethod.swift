//
//  HTTPMethod.swift
//  Swift6WithUIKit
//
//  Created by Luis Rodríguez on 2/2/25.
//

import Foundation

extension URLRequest {
    /// Crea un `URLRequest` con una URL específica.
    init(url: URL, method: HTTPMethod) {
        self.init(url: url)
        self.httpMethod = method.rawValue
    }
    
    /// Devuelve una nueva instancia del `URLRequest` con un encabezado HTTP establecido.
    func setHeader(field: String, value: String) -> URLRequest {
        var request = self
        request.setValue(value, forHTTPHeaderField: field)
        return request
    }
    
    /// Devuelve una nueva instancia del `URLRequest` con múltiples encabezados HTTP establecidos.
    func setHeaders(_ headers: [String: String]) -> URLRequest {
        var request = self
        headers.forEach { request.setValue($0.value, forHTTPHeaderField: $0.key) }
        return request
    }
    
    /// Devuelve una nueva instancia del `URLRequest` con el cuerpo configurado como JSON.
    func setJSONBody<T: Encodable>(_ body: T) throws -> URLRequest {
        var request = self
        let jsonData = try JSONEncoder().encode(body)
        request.httpBody = jsonData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
    
    /// Devuelve una nueva instancia del `URLRequest` con el cuerpo configurado como x-www-form-urlencoded
    func setFormURLEncodedBody(_ parameters: [String: String]) throws -> URLRequest {
        let bodyString = parameters
                    .map { "\($0.key)=\($0.value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")" }
                    .joined(separator: "&")

        var request = self
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpBody = bodyString.data(using: .utf8)
        return request
    }
}

enum HTTPMethod: String {
    case GET
    case POST
    case PUT
    case DELETE
}
