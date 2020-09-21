//
//  Router.swift
//  ParadiseOfDrinks
//
//  Created by ket on 21.09.2020.
//  Copyright © 2020 Ekaterina Romanchenko. All rights reserved.
//

import Foundation
import Alamofire

enum Router: URLRequestConvertible {
    
    case categories
    case cocktailsByCategory(categoryName: String)
    
    var baseURL: URL {
        return URL(string: "https://www.thecocktaildb.com")!
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var path: String {
        switch self {
        case .categories:
            return "/api/json/v1/1/list.php"
        case .cocktailsByCategory:
            return "/api/json/v1/1/filter.php"
        }
    }
    
    var params: [String : String] {
        switch self {
        case .categories:
           return ["c" : "list"]
        case .cocktailsByCategory(let category):
           return ["c": "\(category)"]
        }
    }
    
//    MARK: URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        let encoder = URLEncodedFormParameterEncoder()
        urlRequest = try encoder.encode(params, into: urlRequest)
        return urlRequest
    }
    
}
