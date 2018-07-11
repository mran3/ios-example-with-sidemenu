//
//  NetworkUtilities.swift
//  Class for networking
//
//  Created by Andres Acevedo on 2017.
//  Copyright © 2017 troquer. All rights reserved.
//

import Foundation

class NetworkUtilities {
    static let sharedInstance = NetworkUtilities() //This class is a Singleton
    
    
    /// Creates a request with the parameters and headers received as dictionaries.
    ///
    /// - Parameters:
    ///   - endpoint: URL
    ///   - params: get parameters
    ///   - headers: additonal headers
    /// - Returns: request object
    func createGetRequest(endpoint:String, params:[String:String]? = nil, headers:[String:String]? = nil)->URLRequest{
        let urlComponents = NSURLComponents(string:endpoint)!
        var queryItems = [URLQueryItem]()
        if params != nil {
            for (param, paramValue) in params! {
                queryItems.append(URLQueryItem(name: param, value: paramValue))
            }
            urlComponents.queryItems = queryItems
        }
        var request = URLRequest(url: urlComponents.url!)
        if headers != nil {
            for (header, headerValue) in headers! {
                request.addValue(headerValue, forHTTPHeaderField: header)
            }
        }
        return request
    }
    

    
    
    /// Hace una petición HTTP.
    ///
    /// - Parameters:
    ///   - endpoint: endpoint
    ///   - onSuccess: completion closure
    ///   - onError: failure closure
    /// - Returns: Void
    func makeRequest(endPoint: URLRequest, onSuccess:@escaping (_ data:Data)->Void, onError:@escaping ()->Void = {})->Void{
        let config = URLSessionConfiguration.default
        let session = URLSession.init(configuration: config)
        
        let task = session.dataTask(with: endPoint) { (data, response, error) in
            
            guard error == nil else {
                print("Error de conectividad", error!)
                return
            }
            
            
            if let httpResponse = response as? HTTPURLResponse {
                let statusCode = httpResponse.statusCode
                
                if (statusCode != 200) {
                    print ("dataTaskWithRequest HTTP status code", statusCode)
                    DispatchQueue.main.async {
                        onError()
                    }
                    return
                }
            }
            
            if let data = data {
                onSuccess(data)
            }
            
        }
        task.resume()
    }
    
    
    
    
    
    
    
    
}


